#include <cstdio>
#include <iostream>
#include <string>
#include <vector>
#include "DiscretePFInputs.h"

#define NTEST 100

#define DEBUG 0

int main(){
    if(DEBUG) std::cout<<"test"<<std::endl;
   // const char* dumpfile="/Users/hongjieun/Documents/Correlator/hlsDump/out_VBF.dump";
   const char* dumpfile="/home/jhong/hlsmet/out_TTbar.dump";

    std::vector<std::vector<std::pair<float,float> > > vals;
    vals.resize(NTEST);

    FILE *f = fopen(dumpfile, "rb");
    
    std::vector<l1tpf_int::PFParticle> pfs;
 
    uint64_t ie=0;
//    while (fread(&ie, sizeof(uint64_t), 1, f) && ie<NTEST){
//        readManyFromFile(pfs,f);
//        printf("Event %d has %d PF candidates \n", int(ie), int(pfs.size()));
//        vals[ie].resize(pfs.size());
//
//        for(size_t ip=0; ip<pfs.size(); ip++){
//            vals[ie][ip] = std::make_pair<float,float>(pfs[ip].hwPt, pfs[ip].hwPhi);
//            if( == 0) printf("%04X %04X %04X %04X  ", pfs[j].hwPt, pfs[j].hwPhi, pfs[j].hwEta, int(1));
//        }
//
//    }
//    fclose(f);

    int col = 60;
    int row = 36;

    uint16_t pt;
    uint16_t phi;
    uint16_t eta;
    uint8_t id;

    char s[16];

    FILE *out;
    out=fopen("out_TTbar_conv.dump","w");

//    char input[row][col];
    while (fread(&ie, sizeof(uint64_t), 1, f) && ie<NTEST){
        readManyFromFile(pfs,f);

        for(int i = 0; i <row; i++){
            for(int j = 0; j <col; j++){
                pt  = pfs[j].hwPt < 0 ? (1<<16)+pfs[j].hwPt : pfs[j].hwPt;    // using two's complement
                phi = pfs[j].hwPhi < 0 ? (1<<16)+pfs[j].hwPhi : pfs[j].hwPhi; // -32768 to -1 mapping 32768 to 65536
                eta = pfs[j].hwEta < 0 ? (1<<16)+pfs[j].hwEta : pfs[j].hwEta;
                id  = pfs[j].hwId;

                //if(i == 0) printf("%04X%04X%04X%04X  ", pfs[j].hwPt, pfs[j].hwPhi, pfs[j].hwEta, int(1));
                if(DEBUG){
                if(i == 0) printf("%04X%04X%04X%04X ", pt, phi, eta, id);
                else printf("%04X%04X%04X%04X ", int(0), int(0), int(0), int(0) );
                }

                //convert pt phi eta id to string
                if(i == 0) sprintf(s,"%04X%04X%04X%04X ", pt, phi, eta, id);
                else sprintf(s,"%04X%04X%04X%04X ", int(0), int(0), int(0), int(0) );

                fprintf(out,"%s",s);

                //if(i == 0) fprintf(out, "%04X%04X%04X%04X ", pt, phi, eta, id);
                //else fprintf(out, "%04X%04X%04X%04X ", int(0), int(0), int(0), int(0) );

            }
            if(DEBUG) printf("\n");
            fprintf(out, "\n");
        }
    //    if(DEBUG) printf("\n");
    //    fprintf(out, "\n");

    }
    fclose(out);
}
