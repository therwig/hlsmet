This is a branch for Christian to develop the MET HLS algorithm.
Includes HLS and wrapper for EMP impl.

Create ipbb simulation (Modelsim) project:
```
ipbb proj create sim hlsmet-sim hlsmet: -t top_sim.dep
cd proj/hlsmet-sim
ipbb sim make-project
```

Create VCU118 Vivado project:
```
ipbb proj create vivado hlsmet hlsmet: -t top.dep
cd proj/hlsmet
ipbb vivado make-project -c # -c to use IP cache, should be faster
ipbb vivado synth -j4 impl -j4
```

