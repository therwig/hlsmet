#include <math.h>
#include <cmath>
#include <algorithm>
#include "ap_int.h"
#include "ap_fixed.h"
#include "src/met.h"

void met_ref(float in_pt[NPART], float in_phi[NPART], float& out_pt, float& out_phi){
    if(DEBUG) std::cout << " REF Begin" << std::endl;
    double met_x=0.;
    double met_y=0.;
    for(int i=0;i<NPART;i++){
        met_x -= in_pt[i] * cos(in_phi[i]);
        met_y -= in_pt[i] * sin(in_phi[i]);
        if(DEBUG) std::cout << "     metx = " << met_x << " \t ";
        if(DEBUG) std::cout << "mety = " << met_y << " \n";
    }
    double met2 = pow(met_x,2)+pow(met_y,2);
    out_pt = sqrt(met2);
    if(out_pt<1e-10) out_pt = 1e-10; // guard divide by zero
    out_phi = met_y>=0 ? acos(met_x/out_pt) : -acos(met_x/out_pt);

    if(DEBUG){
        std::cout << "     x/tot = " << met_x/out_pt << " \t ";
        std::cout << "(x/tot)^2 = " << pow(met_x/out_pt,2) << " \t ";
        std::cout << "acos(x/tot) = " << acos(met_x/out_pt) << " \t ";
        std::cout << "rotated = " << out_phi << " \n ";

        std::cout << "     met = " << out_pt << " \t ";
        std::cout << "met2 = " << met2 << " \t ";
        std::cout << "phi = " << out_phi << " \n";
    }
    return;
}

