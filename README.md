# METHLS

The '64words' branch is latest version hls for running at apx.

First, the vivado environment setup is required.
```
source /data/Xilinx/Vivado/Vivado/2019.1/settings64.sh
```

For simple testing 1 event TTbar sample is there. ```TTbar_1evt_54lnk.dump```.

The input file is opened at line 81 of ```met_test.cpp```. It should be change with your path.
```
FILE *fi = fopen("/home/jhong/temp/hlsmet/TTbar_1evt_54lnk.dump","rb");
```

The number of events and number of particles per events can be changed at ```src/met.h```.
```
#define NTEST 1
#define NPART 1
```

Run the vivado_hls.
```
vivado_hls -f do_met.tcl
```
