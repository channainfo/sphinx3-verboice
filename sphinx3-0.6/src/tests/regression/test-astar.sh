#!/bin/sh

echo "ASTAR TEST"
tmpout="test-astar.out"

margs="-mdef src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/hub4opensrc.6000.mdef \
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-wip 0.2 \
-beam 1e-64 \
-nbest 5 \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl.platform_independent \
-inlatdir src/tests/regression/../../../model/lm/an4/ \
-logbase 1.0003 \
-nbestdir .  "

lmargs="-lm src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_astar $margs $lmargs > $tmpout 2>&1 

gzip -cfd ./pittsburgh.nbest.gz > ./pittsburgh.nbest 
if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl ./pittsburgh.nbest src/tests/regression/../../../model/lm/an4/pittsburgh.nbest | grep SUCCESS > /dev/null 2>&1); \
then echo "ASTAR test PASSED"; else \
echo "ASTAR test FAILED"; fi
