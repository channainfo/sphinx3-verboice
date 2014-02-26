#!/bin/sh

tmpout="test-align-mllr.out"
tmplog="test-align-mllr.log"

echo "ALIGN+MLLR TEST simple"
echo "YOU SHOULD SEE THE RECOGNITION RESULT 'P I T T S B U R G H'"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_align \
-logbase 1.0003 \
-mdef src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/hub4opensrc.6000.mdef \
-mean src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/means \
-var src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/variances \
-mixw src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/mixture_weights \
-tmat src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/transition_matrices \
-mllr src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/mllr_matrices \
-feat 1s_c_d_dd \
-agc max \
-topn 1000 \
-beam 1e-80 \
-senmgau .s3cont. \
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl \
-cepdir src/tests/regression/../../../model/lm/an4/ \
-insent src/tests/regression/../../../model/lm/an4/align.correct \
-outsent $tmpout \
-wdsegdir ./ \
-phsegdir ./ \
>$tmplog 2>&1 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpout  src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.align.mllr.out | grep SUCCESS > /dev/null 2>&1); \
then echo "ALIGN+MLLR simple output test PASSED"; else \
echo "ALIGN+MLLR simple output test FAILED"; fi 
