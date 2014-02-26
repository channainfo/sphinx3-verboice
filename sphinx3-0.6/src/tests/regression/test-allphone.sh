#!/bin/sh

#Program we used -agc max. This is an exception

echo "ALLPHONE TEST"
tmpout="test-allphone.out"

margs="-logbase 1.0003 \
-mdef src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/hub4opensrc.6000.mdef \
-mean src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/means \
-var src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/variances \
-mixw src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/mixture_weights \
-tmat src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/transition_matrices \
-feat 1s_c_d_dd \
-topn 1000 \
-beam 1e-80 \
-agc max \
-senmgau .s3cont. \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl \
-cepdir src/tests/regression/../../../model/lm/an4/ \
-hyp allphone.match \
-hypseg allphone.matchseg \
-phsegdir ./ \
-phlatdir ./"

lmargs="-lm src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa.DMP "

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_allphone $margs $lmargs 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl `head -1 src/tests/regression/../../../model/lm/an4/an4.ctl`.allp src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.allphone.phone_tg.allp 2 | grep SUCCESS > /dev/null 2>&1); \
then echo "ALLPHONE PHONE TG allp test PASSED"; else \
echo "ALLPHONE PHONE TG allp test FAILED"; fi

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl `head -1 src/tests/regression/../../../model/lm/an4/an4.ctl`.phlat src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.allphone.phone_tg.phlat | grep SUCCESS > /dev/null 2>&1); \
then echo "ALLPHONE PHONE TG phlat test PASSED"; else \
echo "ALLPHONE PHONE TG phlat test FAILED"; fi

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl allphone.match src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.allphone.phone_tg.match | grep SUCCESS > /dev/null 2>&1); \
then echo "ALLPHONE PHONE TG match test PASSED"; else \
echo "ALLPHONE PHONE TG match test FAILED"; fi

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl allphone.matchseg src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.allphone.phone_tg.matchseg 2 | grep SUCCESS > /dev/null 2>&1); \
then echo "ALLPHONE PHONE TG matchseg test PASSED"; else \
echo "ALLPHONE PHONE TG matchseg test FAILED"; fi

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_allphone $margs

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl `head -1 src/tests/regression/../../../model/lm/an4/an4.ctl`.allp src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.allphone.allp 2 | grep SUCCESS > /dev/null 2>&1); \
then echo "ALLPHONE PHONE LOOP allp test PASSED"; else \
echo "ALLPHONE PHONE LOOP allp test FAILED"; fi

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl `head -1 src/tests/regression/../../../model/lm/an4/an4.ctl`.phlat src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.allphone.phlat | grep SUCCESS > /dev/null 2>&1); \
then echo "ALLPHONE PHONE LOOP phlat test PASSED"; else \
echo "ALLPHONE PHONE LOOP phlat test FAILED"; fi

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl allphone.match src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.allphone.match | grep SUCCESS > /dev/null 2>&1); \
then echo "ALLPHONE PHONE LOOP match test PASSED"; else \
echo "ALLPHONE PHONE LOOP match test FAILED"; fi

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl allphone.matchseg src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.allphone.matchseg 2 | grep SUCCESS > /dev/null 2>&1); \
then echo "ALLPHONE PHONE LOOP matchseg test PASSED"; else \
echo "ALLPHONE PHONE LOOP matchseg test FAILED"; fi

