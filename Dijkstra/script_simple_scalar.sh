#!/bin/bash

SIM_OUTORDER=/usr/ensta/pack/simplescalar-3v0d/simplesim-3.0/sim-outorder

PRG_SS="dijkstra_small input.dat"
REDIR_OUT_SIMU="-redir:sim simu.out"
OPTIONS="-issue:inorder true -max:inst 10000"


 sim-outorder-bpred bimod-fetch :mplat 8-fetch :ifqsize 4-decode :width 2-issue :width 4-issue :inorder false-commit :width 2-ruu :size 2-lsq :size 8-res :memport 2-res :ialu 1-res :imult 1-res :fpalu 1-res :fpmult 1-cache :il1 il1 :16 :32 :2 :l-cache :dl1
 dl1 :16 :32 :2 :l-cache :dl2 ul2 :2048 :32 :8 :l-redir :sim
 dijkstra_small.txt dijkstra_small.ss


OPTIONSA7="\
    -cache:il1 il1:512:32:2:l \
    -cache:dl1 dl1:256:32:2:l \
    -cache:dl2 dl2:512:32:8:l \
    -bpred bimod -bpred:btb 256 \
    -fetch:mplat 8 \
    -fetch:ifqsize 4 \
    -decode:width 2 -issue:width 4 -commit:width 2 \
    -ruu:size 2 -lsq:size 8 \
    -res:ialu 1 -res:imult 1 -res:fpalu 1 -res:fpmult 1 \
    -issue:inorder false "


$SIM_OUTORDER $OPTIONSA7 $REDIR_OUT_SIMU $PRG_SS


