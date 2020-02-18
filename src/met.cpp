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
void met_hw(word_t inputs[NPART],  pt2_t& res_pt2, phi_t& res_phi){
//void met_hw(word_t inputs[NPART],  word_t& output){
    //#pragma HLS ARRAY_PARTITION variable=data_pt complete
    //#pragma HLS ARRAY_PARTITION variable=data_phi complete
    #pragma HLS pipeline ii=36
    
    if(DEBUG) std::cout << "  HW Begin" << std::endl;

	//std::string words[NPART];
	//std::string words_ptphi[2][NPART];
	//int temp_pt[NPART], temp_phi[NPART];
	var_t data_pt[NPART]; var_t data_phi[NPART];  //var_t is ap_int<16>
	size_t Length;
	for(int i = 0; i < 60; i++){
		data_pt[i]  = inputs[i](63,48);
		data_phi[i] = inputs[i](47,32);
		//words[i] = inputs[i];
		//words_ptphi[0][i] = words[i].substr(0,4);
		//words_ptphi[1][i] = words[i].substr(4,4);

		if(DEBUG2) std::cout<<"word pt phi: "<<data_pt[i]<<" "<<data_phi[i]<<std::endl;

		//if(data_pt[i]==0 && data_phi[i]==0) continue;

		//temp_pt[i]  = stoi(words_ptphi[0][i], &Length, 16); if(temp_pt[i]  >(1<<15)) temp_pt[i]  = temp_pt[i] - (1<<16);
		//temp_phi[i] = stoi(words_ptphi[1][i], &Length, 16); if(temp_phi[i] >(1<<15)) temp_phi[i] = temp_phi[i] - (1<<16);

		//data_pt[i] = temp_pt[i] * (1<<2); // PT_DEC_BITS 0.25 GeV precision
		//data_phi[i] = int(temp_phi[i] * (1<<PHI_SIZE)/(2*FLOATPI));
	}
	//pt2_t res_pt2;

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

	//pt_t res_pt; phi_t res_phi;
    PhiFromXY(sum_x,sum_y,res_pt2,res_phi);

    //res_pt = hls::sqrt(res_pt2);
    // pack outputs into a single word
    //output = 0 + (0<<16) + (res_phi<<32) + (res_pt<<48);

    return;
}

