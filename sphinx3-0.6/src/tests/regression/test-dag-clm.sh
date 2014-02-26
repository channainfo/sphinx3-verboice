#!/bin/sh

echo "DAG CLASS-BASED LM TEST"
tmpout="test-dag-clm.out"

margs="-mdef src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/hub4opensrc.6000.mdef \
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-lw 13.0 \
-wip 0.2 \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl.platform_independent \
-inlatdir src/tests/regression/../../../model/lm/an4/ \
-logbase 1.0003 \
-backtrace 1 "

#lmargs="-lm src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP"

clsargs="-lmctlfn src/tests/regression/../../.././model/lm/an4/an4.ug.cls.lmctl \
-ctl_lm  src/tests/regression/../../../model/lm/an4/an4.ctl_lm" 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_dag $margs $clsargs > $tmpout 2>&1 

grep "BSTPTH:" $tmpout 
grep "BSTXCT" $tmpout 

if(grep "BSTPTH:" $tmpout |grep "P I T T S B U R G H" > /dev/null 2>&1); \
then echo "DAG CLASS-BASED LM test PASSED" ; else \
echo "DAG CLASS-BASED LM test FAILED" ; fi
