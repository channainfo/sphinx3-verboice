#!/bin/sh

tmpout="test-decode-mode3.out"

echo "DECODE MODE 3 TEST"
echo "YOU SHOULD SEE THE RECOGNITION RESULT 'P I T T S B U R G H'"

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
-op_mode 3 \
-subvqbeam 1e-02 \
-epl 4 \
-fillprob 0.02 \
-feat 1s_c_d_dd \
-lw 9.5 \
-beam 1e-40 \
-wbeam 1e-20 \
-wend_beam 1e-1 \
-ci_pbeam 1e-5 \
-ds 2 \
-tighten_factor 0.4"

lmargs="-lm src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP"

clsargs="-lmctlfn src/tests/regression/../../../model/lm/an4/an4.ug.cls.lmctl \
-ctl_lm  src/tests/regression/../../../model/lm/an4/an4.ctl_lm" 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_decode $margs $lmargs > $tmpout 2>&1
grep "FWDVIT" $tmpout
grep "FWDXCT" $tmpout

if(grep "FWDVIT" $tmpout |grep "P I T T S B U R G H" > /dev/null 2>&1); \
then echo "DECODE MODE 3 test PASSED" ; else \
echo "DECODE MODE 3 test FAILED" ; fi



