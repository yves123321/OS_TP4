#!/bin/bash  

SIM_OUTORDER=/usr/ensta/pack/simplescalar-3v0d/simplesim-3.0/sim-outorder

PRG_SS="sha_driver.ss input_small.asc"
OPTIONS="-issue:inorder true -max:inst 10000"

# Paramètres fixes du Cortex A15
BPRED="-bpred 2lev -bpred:btb 256 4"
FETCH="-fetch:mplat 15 -fetch:ifqsize 8"
DECODE="-decode:width 4 -issue:width 8 -commit:width 4"
RUU_LSQ="-ruu:size 16 -lsq:size 16"
RESOURCES="-res:ialu 5 -res:imult 1 -res:fpalu 1 -res:fpmult 1"
ISSUE="-issue:inorder false"

# Taille du cache L2 fixe
L2_CACHE="-cache:dl2 dl2:512:64:16:l"

# Boucle pour tester différentes tailles de caches L1
for L1_SIZE_KB in 1 2 4 8 16; do
    L1_SIZE=$((L1_SIZE_KB * 1024 / (64 * 2)))  # Calcul du nombre de sets
    IL1_CACHE="-cache:il1 il1:${L1_SIZE}:64:2:l"
    DL1_CACHE="-cache:dl1 dl1:${L1_SIZE}:64:2:l"
    
    OUTPUT_FILE="sim.out15_${L1_SIZE_KB}KB"
    
    echo "Exécution avec L1I = ${L1_SIZE_KB}KB, L1D = ${L1_SIZE_KB}KB"
    $SIM_OUTORDER $OPTIONS $BPRED $FETCH $DECODE $ISSUE $RUU_LSQ $RESOURCES $IL1_CACHE $DL1_CACHE $L2_CACHE $PRG_SS > "$OUTPUT_FILE" 2>&1
    
    echo "Résultats enregistrés dans $OUTPUT_FILE"
done
