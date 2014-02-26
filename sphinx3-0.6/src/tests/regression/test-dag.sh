#!/bin/sh

echo "DAG TEST"
tmpout="test-dag.out"

margs="-mdef src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/hub4opensrc.6000.mdef \
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-lw 13.0 \
-wip 0.2 \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl.platform_independent \
-inlatdir src/tests/regression/../../../model/lm/an4/ \
-logbase 1.0003 \
-backtrace 1 "

lmargs="-lm src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_dag $margs $lmargs > $tmpout 2>&1 

grep "BSTPTH:" $tmpout 
grep "BSTXCT" $tmpout 

if(grep "BSTPTH:" $tmpout |grep "P I T T S B U R G H" > /dev/null 2>&1); \
then echo "DAG test PASSED" ; else \
echo "DAG test FAILED" ; fi
