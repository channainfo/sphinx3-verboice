#!/bin/sh

tmpout="test-decode-mode1369.out"

echo "DECODE MODE 1369 (DEBUG MODE) TEST"
echo "This matches the current decoding routine call sequence with the default behaviour"

margs="-mdef src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/hub4opensrc.6000.mdef \
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-mean src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/means \
-var src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/variances \
-mixw src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/mixture_weights \
-tmat src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/transition_matrices \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl \
-cepdir src/tests/regression/../../../model/lm/an4/ \
-agc none \
-varnorm no \
-cmn current \
-subvqbeam 1e-02 \
-epl 4 \
-fillprob 0.02 \
-feat 1s_c_d_dd \
-lw 9.5 \
-maxwpf 1 \
-beam 1e-40 \
-pbeam 1e-30 \
-wbeam 1e-20 \
-maxhmmpf 1500 \
-wend_beam 1e-1 \
-ci_pbeam 1e-5 \
-ds 2 \
-tighten_factor 0.4 \
-op_mode 1369"

lmargs="-lm src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP"

clsargs="-lmctlfn src/tests/regression/../../../model/lm/an4/an4.ug.cls.lmctl \
-ctl_lm  src/tests/regression/../../../model/lm/an4/an4.ctl_lm" 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_decode $margs $lmargs  2>&1 | grep "SEARCH DEBUG" |sed "s/\.//g" > $tmpout

if( diff $tmpout src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/test.mode1369.dump > /dev/null 2>&1); \
then echo "DECODE MODE 1369 (DEBUG MODE) test PASSED" ; else \
echo "DECODE MODE 1369 (DEBUG MODE) test FAILED" ; fi



