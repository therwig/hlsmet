/*
  HLS implementation of MET calculation from PF objects
*/
#include "met.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#include <string>
#endif

// pt, phi are integers
//void met_hw(word_t inputs[NPART],  pt2_t& res_pt2, phi_t& res_phi){
//void met_hw(word_t inputs[NPART],  word_t &output){
void met_hw(hls::stream<PFInputWords> &inputs, hls::stream<word_t> &output){
    //#pragma HLS dataflow
    //#pragma HLS pipeline ii=36
    //#pragma HLS ARRAY_PARTITION variable=inputs complete

    if(DEBUG) std::cout << "  HW Begin" << std::endl;

    pt_t data_pt[NLINKSIN]; 
    phi_t data_phi[NLINKSIN];
#pragma HLS ARRAY_PARTITION variable=data_pt complete
#pragma HLS ARRAY_PARTITION variable=data_phi complete

    // calc signed x,y components first
    pxy_t sum_x = 0;
    pxy_t sum_y = 0;
    
 PARTICLE_LOOP: 
    for(int i = 0; i < DIV_ROUNDUP(NPART,NLINKSIN); i++){
        PFInputWords input_array = inputs.read();

    #pragma unroll
    LINK_LOOP: 
        for(int j = 0; j < NLINKSIN; j++){
            data_pt[j]  = input_array.data[j](63,48);
            data_phi[j] = input_array.data[j](47,32);

            if(DEBUG) std::cout<<"word pt phi: "<<data_pt[i]<<" "<<data_phi[i]<<std::endl;

            // Get x, y components
            pxy_t met_x = 0;
            pxy_t met_y = 0;
            ProjX(data_pt[j], data_phi[j], met_x);
            ProjY(data_pt[j], data_phi[j], met_y);
            // Add to x, y sums
            sum_x -= met_x;
            sum_y -= met_y;
            if(DEBUG){
                std::cout << "     met x,y = (" << -met_x << ", " << -met_y << ") \t";
                std::cout << " sum x,y = (" << sum_x << ", " << sum_y << ") \t";
                std::cout << " \n";
            }
        }
    }


    pt2_t res_pt2;
    res_pt2 = sum_x*sum_x + sum_y*sum_y;

    pt_t res_pt; phi_t res_phi;
    PhiFromXY(sum_x,sum_y,res_pt2,res_phi);

    res_pt = hls::sqrt(res_pt2);

    if(DEBUG) std::cout<<"hw out res_pt&phi : "<<res_pt<<", "<<res_phi<<std::endl;

    word_t outword = ( res_pt, res_phi, ap_uint<32>(0) );
    output.write( outword );
    return;

    // ap_uint<16> var_pt, var_phi;
    // ap_uint<64> var2_pt, var2_phi;
    // var_pt = res_pt;
    // var_phi = res_phi; //if( res_phi < 0 ) var_phi = (1<<16)+res_phi;
    // if(DEBUG) std::cout<<"var_pt & phi : "<<var_pt<<", "<<var_phi<<std::endl;

    // // pack outputs into a single word
    // var2_phi = var_phi;
    // var2_pt = var_pt;
    // if(DEBUG) std::cout<<"var2_pt & phi : "<<var2_pt<<", "<<var2_phi<<std::endl;
    // output.write( word_t(0 + (0<<16) + (var2_phi<<32) + (var2_pt<<48)) );
    // //output = 0 + (0<<16) + (var2_phi<<32) + (var2_pt<<48);
    // //output = 0 + (0<<16) + (res_phi<<32) + (res_pt<<48);

    return;
}

