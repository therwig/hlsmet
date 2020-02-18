/*
MET calculation from PF objects
*/
#include <vector>
#include <cstdio>
#include <utility>
#include <random>
#include <istream>
#include "ap_int.h"
#include "ap_fixed.h"
#include "src/met.h"
#include "DiscretePFInputs.h"

int alg_test(const char* dumpfile="") {
    // The conventional test algorithm that compares the final outputs 
    // of HLS and floating point calculations

    // calculate met for NPART particles
    word_t inputs[NPART];
    word_t output;
	float inputs_ref[NPART];
	float output_ref;

    //pt_t  in_pt_hw[NPART];
   // phi_t in_phi_hw[NPART];
    pt2_t out_pt2_hw;
    phi_t out_phi_hw;

    float in_pt[NPART], in_phi[NPART];
    float out_pt, out_phi;


    // load the dump file output
	std::vector<std::vector<std::pair<float,float> > > vals; 
	if(*dumpfile){
		// in any case, initialize to zeros
		vals.resize(NTEST);
		for(int i=0; i<NTEST; i++){
			vals[i].resize(NPART);
		}
		// load the dump file output
		FILE *f = fopen("/home/jhong/hlsmet/out_TTbar.dump","rb");
		std::vector<l1tpf_int::PFParticle> pfs;

		uint64_t ie=0;
		while ( fread(&ie, sizeof(uint64_t), 1, f) && ie<NTEST) {
			//if (ie>1000) break;
			readManyFromFile(pfs,f);
			printf("Event %d has %d PF candidates \n", int(ie), int(pfs.size()));
			for(size_t ip=0;ip<pfs.size() && ip<NPART;ip++){
				vals[ie][ip] = std::make_pair<float,float>(pfs[ip].hwPt, pfs[ip].hwPhi);
			}
		}
		fclose(f);

		//uint64_t ii=0;
		//char s[32];
		//char deli[2];
		//std::string trush;

		//FILE *fi = fopen("/home/jhong/hlsmet/out_TTbar_conv.dump","rb");
		//while ( fread(&s, 17, 1, fi) && ii<NTEST) {
		//	std::cout<<"ii "<<ii<<std::endl;
		//	if (ii>2) break;
		//	//printf("Event %d has %d PF candidates \n", int(ie), int(pfs.size()));
		//	for(int clk = 0; clk < 36; clk++){
		//	for(size_t ip=0; ip<60;ip++){
        //        fread(&s, 16, 1, fi);
		//		fread(&deli, 1, 1, fi);
		//		if( uint64_t(s) == 0) continue;
		//		std::cout<<"["<<ip+clk*60<<"] "<<s<<std::endl;
		//		//data[ip+clk] = s;
		//		//std::cout<<"data["<<ip+clk<<"] "<<data[ip+clk]<<std::endl;
		//	}}
		//	ii++;
		//}

		//fclose(fi);
	} else {
		std::cout<<"do random"<<std::endl;
		//setup random number generator
		std::default_random_engine generator(1776); // seed
		std::uniform_real_distribution<float> pt_dist(10.,100.);
		// random pt uniformly distributed between 10 and 100 GeV for each particle
		std::uniform_real_distribution<float> phi_dist(-FLOATPI,FLOATPI);
		// random uniform phi
		// Dimensions: #events=NTEST x #particles=NPART
		// type is a pair: (pt,phi)
		vals.resize(NTEST);
		for(int i=0; i<NTEST; i++){
			vals[i].resize(NPART);
			for(int j=0; j<NPART; j++){
				vals[i][j].first  = pt_dist(generator);
				vals[i][j].second = phi_dist(generator);
			}
		}
	}
    //write results to file
    FILE *result;
    result=fopen("results.txt","w");

	FILE *fi = fopen("/home/jhong/hlsmet/out_TTbar_conv.dump","rb");
	std::string inputs_string[NPART];
	char s[17];
	char temp;
	size_t Length;

    for (int i=0; i<NTEST; ++i) {
		//if(i>1000) continue;
        if(1) std::cout << "\n\nEvent " << i << std::endl;
		
		fread(&temp, sizeof(char), 1, fi);
		for(int clk = 0; clk < 36; clk++){
			//if(clk != 0) continue;
		for(int j = 0; j<60; j++){
				int si = 0;
				if(DEBUG2 && clk==0) std::cout<<"\ndo "; 
				//if((clk*60+j)%6 == 0) std::cout<<clk*60+j<<" ";
			while(1){
				if(temp == ' '||temp=='\n'){
					fread(&temp, sizeof(char),1,fi);
					continue;
				}
				if(DEBUG2 && clk==0) std::cout<<si<<" ";
				s[si] = temp;
				fread(&temp, sizeof(char),1,fi);
				si++;
				if(si == 16) { s[si] = '\0'; break;}
			}
			if(clk==0){
				inputs_string[clk*60+j] = s;
				if(DEBUG2) std::cout<<"\ninputs_string["<<clk*60+j<<"] "<<s<<std::endl;
				inputs[clk*60+j] = stol(inputs_string[clk*60+j], &Length, 16);
				if(DEBUG2) std::cout<<"--> inputs["<<clk*60+j<<"] "<<inputs[clk*60+j]<<std::endl;
			}

		}}
        for(int j=0; j<60; j++){
            //// convert float to hw units
            //in_pt_hw[j]  = vals[i][j].first * (1<<PT_DEC_BITS); // 0.25 GeV precision
            //in_phi_hw[j] = int(vals[i][j].second * (1<<PHI_SIZE)/(2*FLOATPI));
            // keep test vals as float
            in_pt[j]  = vals[i][j].first;
            in_phi[j] = vals[i][j].second;
			if(DEBUG){
				std::cout << " \t part pt " << in_pt[j];
				std::cout << "\t phi " << in_phi[j];
				std::cout << std::endl;
			}
        }

        out_pt2_hw=0.; out_phi_hw=0.;
        out_pt=0.; out_phi=0.;

		output_ref = 0; //output = 0;
        
        // run reference alg
        //met_ref(inputs_ref, output_ref);
		met_ref(in_pt, in_phi, out_pt, out_phi);
		//met_ref(inputs_ref, output_ref);

        // run HW alg
        //met_hw(inputs, output);
        met_hw(inputs, out_pt2_hw, out_phi_hw);
		//met_hw(in_pt_hw, in_phi_hw, out_pt2_hw, out_phi_hw);


        if(DEBUG) std::cout << " REF : met(pt = " << out_pt << ", phi = "<< out_phi << ")\n";
        // for HW alg, convert back to nice units for printing
        int out_phi_hw_int = float(out_phi_hw);
        //float out_phi_hw_rad = float(out_phi_hw);
        //float out_pt_hw = sqrt(float(out_pt2_hw));
        float out_phi_hw_rad = float(out_phi_hw) * (2*FLOATPI)/(1<<PHI_SIZE);
        float out_pt_hw = sqrt(float(out_pt2_hw)) / (1<<PT_DEC_BITS); // 0.25GeV to GeV
        if(DEBUG) std::cout << "  HW : met(pt = " << out_pt_hw << ", phi = "<< out_phi_hw_rad << ")\n";

        //if not debugging the full event details, print a compact output (in nice units)
        if(false && !DEBUG && NTEST<=100)
            std::cout << "Event " << i
                      << " (REF vs HW) met " << out_pt << " vs " << out_pt_hw
                      << ", phi "<< out_phi << " vs "<< out_phi_hw_rad << "\n";
        fprintf(result, "%f %f %f %f \n", out_pt, out_phi, out_pt_hw, out_phi_hw_rad);
        //fprintf(f, "%f %f %f %d \n", out_pt, out_phi, out_pt_hw, out_phi_hw_int);
    }
	fclose(fi);
    fclose(result);

    return 0;
}


int full_alg_test() {
    // Not really a test alg in the conventional sense, but rather 
    // a step-by-step comparison for each element of the algorithm
    // that we can check to see where any differences may arise
    // between the HLS and floating point calculations

    // calculate met for NPART particles
    pt_t in_pt_hw[NPART];
    pt2_t out_pt2_hw;
    phi_t in_phi_hw[NPART], out_phi_hw;
    float in_pt[NPART], in_phi[NPART];
    float out_pt, out_phi;

    //setup random
    std::default_random_engine generator(1776); // seed
    std::uniform_real_distribution<float> pt_dist(10.,100.);
    std::uniform_real_distribution<float> phi_dist(-FLOATPI,FLOATPI);

    //fill test data
    std::vector<std::vector<std::pair<float,float> > > vals;
    vals.resize(NTEST);
    for(int i=0; i<NTEST; i++){
        vals[i].resize(NPART);
        for(int j=0; j<NPART; j++){
            vals[i][j].first  = pt_dist(generator);
            vals[i][j].second = phi_dist(generator);
            if(0){
                std::cout << vals[i][j].first  << "  ";
                std::cout << vals[i][j].second << "\n";
            }
        }
    }

    //write results to file
    FILE *f;
    //f=fopen(("full_results_"+std::to_string(NPART)+"part_"+std::to_string(NTEST/1000)+"kevt.txt").c_str(),"w");
    f=fopen("full_results.txt","w");

    for (int i=0; i<NTEST; ++i) {
        for(int j=0; j<NPART; j++){
            // convert float to hw
            in_pt_hw[j]  = std::round(vals[i][j].first * (1<<PT_DEC_BITS)); // 0.25 GeV precision
            in_phi_hw[j] = std::round(vals[i][j].second * (1<<PHI_SIZE)/(2*FLOATPI));
            // keep test vals as float
            in_pt[j]  = vals[i][j].first;
            in_phi[j] = vals[i][j].second;
        }
        out_pt2_hw=0.; out_phi_hw=0.;
        out_pt=0.; out_phi=0.;

        //
        // here, replace the abstracted MET algs with the sidy-by-side calc
        //

        // Ref
        double met_x=0.;
        double met_y=0.;
        for(int ip=0;ip<NPART;ip++){
            met_x -= in_pt[ip] * cos(in_phi[ip]);
            met_y -= in_pt[ip] * sin(in_phi[ip]);
        }
        double met2 = pow(met_x,2)+pow(met_y,2);
        out_pt = sqrt(met2);
        if(out_pt<1e-10) out_pt = 1e-10; // guard divide by zero
        out_phi = met_y>=0 ? acos(met_x/out_pt) : -acos(met_x/out_pt);
        double ratio = 0.;
        if(met_x && met_y) ratio = std::min(fabs(met_y/met_x),fabs(met_x/met_y));

        // HW
        pxy_t hw_met_x = 0;
        pxy_t hw_met_y = 0;
        pxy_t hw_sum_x = 0;
        pxy_t hw_sum_y = 0;
        for(int ip=0; ip<NPART;ip++){
            // Get x, y components
            bool debug=false;//(i==163);
            ProjX(in_pt_hw[ip], in_phi_hw[ip], hw_met_x, debug);
            ProjY(in_pt_hw[ip], in_phi_hw[ip], hw_met_y, debug);
            // Add to x, y sums
            hw_sum_x -= hw_met_x;
            hw_sum_y -= hw_met_y;
        }
        pt2_t out_pt2_hw = hw_sum_x*hw_sum_x + hw_sum_y*hw_sum_y;
        pt_t hw_ratio;
        PhiFromXY<pxy_t, phi_t, phi_t>(hw_sum_x,hw_sum_y,out_pt2_hw,out_phi_hw);//, hw_ratio);


        //
        // end calc, perform some reformatting for output tests
        //

        float out_phi_hw_rad = float(out_phi_hw) * (2*FLOATPI)/(1<<PHI_SIZE); // int to radians
        float out_pt_hw = sqrt(float(out_pt2_hw)) / (1<<PT_DEC_BITS); // 0.25GeV to GeV
        float float_hw_sum_x = float(hw_sum_x) / (1<<PT_DEC_BITS); // 0.25GeV to GeV
        float float_hw_sum_y = float(hw_sum_y) / (1<<PT_DEC_BITS); // 0.25GeV to GeV
        float float_hw_ratio = float(hw_ratio) / (1<<PT_SIZE); // 2^16 or what have you
        double hw_ratio_nolut = 0.;
        if(float_hw_sum_x && float_hw_sum_y) 
            hw_ratio_nolut = std::min(fabs(float_hw_sum_y/float_hw_sum_x),
                                      fabs(float_hw_sum_x/float_hw_sum_y));

        fprintf(f, "%f %f %f %f %f %f %f %f %f %f %f \n", out_pt, out_phi, met_x, met_y, ratio,
                out_pt_hw, out_phi_hw_rad, float_hw_sum_x, float_hw_sum_y, float_hw_ratio, hw_ratio_nolut);

        if(0 && (out_pt_hw/out_pt<0.8 || out_pt_hw/out_pt>1.2)){
            std::cout << "Event " << i
                      << " (REF vs HW) met " << out_pt << " vs " << out_pt_hw
                      << ", phi "<< out_phi << " vs "<< out_phi_hw_rad << "\n";
            printf("%f %f %f %f %f %f %f %f %f %f \n", out_pt, out_phi, met_x, met_y, ratio,
                   out_pt_hw, out_phi_hw_rad, float_hw_sum_x, float_hw_sum_y, float_hw_ratio);
            std::cout << "  " << hw_sum_x << "  " << hw_sum_y << std::endl;
        }

    }
    fclose(f);

    return 0;
}

int main() {

    // test the algorithm
    alg_test("/home/jhong/hlsmet/out_TTbar_conv.dump");
    //full_alg_test();

    return 0;
}
