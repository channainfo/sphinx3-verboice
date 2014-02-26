#!/bin/sh

tmpout="test-decode-mllr.out"

echo "DECODE+MLLR TEST"
echo "YOU SHOULD SEE THE RECOGNITION RESULT 'P I T T S B U R G H'"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_decode \
-mdef src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/hub4opensrc.6000.mdef \
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-mean src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/means \
-var src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/variances \
-mixw src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/mixture_weights \
-tmat src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/transition_matrices \
-mllr src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/mllr_matrices \
-lm src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP \
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
-ds 2  > $tmpout 2>&1
grep "FWDVIT" $tmpout
grep "FWDXCT" $tmpout

if(grep "FWDVIT" $tmpout |grep "P I T T S B U R G H" > /dev/null 2>&1); \
then echo "DECODE MLLR test PASSED" ; else \
echo "DECODE MLLR test FAILED" ; fi
