/*
HLS implementation of MET calculation from PF objects
*/
#include "met.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

// this is an example of how to build a data input word from the types we want to encode
typedef ap_uint<64> word_t;
typedef ap_uint<16> word_pt_t;
typedef ap_uint<16> word_eta_t;
typedef ap_uint<16> word_phi_t;
typedef ap_uint<16> word_id_t;

word_pt_t my_pt = 30;
word_eta_t my_eta = 10;
word_phi_t my_phi = 32;
word_id_t my_id = 2;

// see https://github.com/therwig/GlobalCorrelator_HLS/blob/tmux_regionizer/firmware/mp7pf_encoding.h
word_id_t my_word = (my_pt,my_etam,my_phi,my_id);
word_id_t my_word = my_id + (my_eta<<16) + (my_phi<<32)+(my_pt<<48);

// pt, phi are integers
void met_hw(word_t inputs[NPART], word_t &output){
//void met_hw(pt_t data_pt[NPART], phi_t data_phi[NPART], pt2_t& res_pt2, phi_t& res_phi){
    #pragma HLS ARRAY_PARTITION variable=data_pt complete
    #pragma HLS ARRAY_PARTITION variable=data_phi complete
    #pragma HLS pipeline ii=6
    
    // ''unpack'' the 64b words to recover pt and phi
    pt_t data_pt[NPART], phi_t data_phi[NPART];
    LOOP_UNPACK: for(int i=0; i<NPART;i++){
        data_pt[i] = inputs[i](48,64); 
        data_phi[i] = inputs[i](16,32);
    }
    // output components
    pt_t res_pt, phi_t res_phi;
    
    if(DEBUG) std::cout << "  HW Begin" << std::endl;

    // calc signed components first
    pxy_t met_x = 0;
    pxy_t met_y = 0;
    pxy_t sum_x = 0;
    pxy_t sum_y = 0;
    LOOP_COMPONENTS: for(int i=0; i<NPART;i++){
        // Get x, y components
        ProjX(data_pt[i], data_phi[i], met_x);
        ProjY(data_pt[i], data_phi[i], met_y);
        // Add to x, y sums
        sum_x -= met_x;
        sum_y -= met_y;
         if(DEBUG){
             std::cout << "     met x,y = (" << -met_x << ", " << -met_y << ") \t";
             std::cout << " sum x,y = (" << sum_x << ", " << sum_y << ") \t";
             std::cout << " \n";
         }
    }

    res_pt2 = sum_x*sum_x + sum_y*sum_y;

    //PhiFromXY<pxy_t, phi_t, phi_t>(sum_x,sum_y,res_phi);
    PhiFromXY(sum_x,sum_y,res_pt2,res_phi);

    pt_t res_pt = hls::sqrt(res_pt2);
    // pack outputs into a single word    
    output = 0 + (0<<16) + (res_phi<<32)+(res_pt<<48);
    
    return;
}

