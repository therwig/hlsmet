/*
HLS implementation of MET calculation from PF objects
*/
#include "met.h"
#include <cmath>
#include <cassert>
#ifndef __SYNTHESIS__
#include <cstdio>
#endif

// pt, phi are integers
void met_hw(pt_t data_pt[NPART], phi_t data_phi[NPART], pt2_t& res_pt2, phi_t& res_phi){
    #pragma HLS ARRAY_PARTITION variable=data_pt complete
    #pragma HLS ARRAY_PARTITION variable=data_phi complete

    #pragma HLS pipeline ii=54
    
    if(DEBUG) std::cout << "  HW Begin" << std::endl;

    pt_t data_pt_int[NPART];
    phi_t data_phi_int[NPART];
    #pragma HLS ARRAY_PARTITION variable=data_pt_int complete
    #pragma HLS ARRAY_PARTITION variable=data_phi_int complete

    FILL_INTERNAL: for(int i=0; i<NPART;i++){
#pragma HLS UNROLL
        data_pt_int[i]=data_pt[i];
        data_phi_int[i]=data_phi[i];
    }

    // calc signed components first
    pxy_t met_x[NPART];
    pxy_t met_y[NPART];
    LOOP_PROJECT: for(int i=0; i<NPART;i++){
#pragma HLS UNROLL
        // Get x, y components
        ProjX(data_pt_int[i], data_phi_int[i], met_x[i]);
        ProjY(data_pt_int[i], data_phi_int[i], met_y[i]);
    }

    pxy_t sum_x = 0;
    pxy_t sum_y = 0;
    SUM: for(int i=0; i<NPART;i++){
#pragma HLS UNROLL
        // Add to x, y sums
        sum_x -= met_x[i];
        sum_y -= met_y[i];
         if(DEBUG){
             std::cout << "     met x,y = (" << -met_x[i] << ", " << -met_y[i] << ") \t";
             std::cout << " sum x,y = (" << sum_x << ", " << sum_y << ") \t";
             std::cout << " \n";
         }
    }

    res_pt2 = sum_x*sum_x + sum_y*sum_y;
    //PhiFromXY(sum_x,sum_y,res_phi);
    res_phi=0;

    return;
}

