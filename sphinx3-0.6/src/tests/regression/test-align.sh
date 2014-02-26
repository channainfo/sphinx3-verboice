#!/bin/sh

echo "ALIGN TEST simple"

tmpout="test-align-simple.seg"

#Simple test
sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_align \
-logbase 1.0003 \
-mdef src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/hub4opensrc.6000.mdef \
-mean src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/means \
-var src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/variances \
-mixw src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/mixture_weights \
-tmat src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/transition_matrices \
-feat 1s_c_d_dd \
-topn 1000 \
-beam 1e-80 \
-senmgau .s3cont. \
-agc max \
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl \
-cepdir src/tests/regression/../../../model/lm/an4/ \
-insent src/tests/regression/../../../model/lm/an4/align.correct \
-outsent $tmpout \
-wdsegdir ./ \
-phsegdir ./ > test-align-simple.out 2>&1

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpout  src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.align.out | grep SUCCESS > /dev/null 2>&1); \
then echo "ALIGN simple output test PASSED"; else \
echo "ALIGN simple output test FAILED"; fi 
if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl `head -1 src/tests/regression/../../../model/lm/an4/an4.ctl`.wdseg src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.align.wdseg | grep SUCCESS > /dev/null 2>&1); \
then echo "ALIGN simple wdseg test PASSED"; else \
echo "ALIGN simple wdseg test FAILED"; fi 
if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl `head -1 src/tests/regression/../../../model/lm/an4/an4.ctl`.phseg src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.align.phseg | grep SUCCESS > /dev/null 2>&1 ); \
then echo "ALIGN simple phseg test PASSED"; else \
echo "ALIGN simple phseg test FAILED"; fi 

tar cf test-align-simple.tar $tmpout `head -1 src/tests/regression/../../../model/lm/an4/an4.ctl`.wdseg `head -1 src/tests/regression/../../../model/lm/an4/an4.ctl`.phseg

echo "ALIGN TEST cepext"

tmpout="test-align-cepext.seg"

#Program we used -agc max. This is an exception
#test for extension
sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_align \
-logbase 1.0003 \
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
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl \
-cepdir src/tests/regression/../../../model/lm/an4/ \
-cepext .abcd \
-insent src/tests/regression/../../../model/lm/an4/align.correct \
-outsent $tmpout \
-wdsegdir ./ \
-phsegdir ./ > test-align-cepext.out 2>&1

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpout  src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.align.out | grep SUCCESS > /dev/null 2>&1); \
then echo "ALIGN cepext output test PASSED"; else \
echo "ALIGN cepext output test FAILED"; fi 
if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl `head -1 src/tests/regression/../../../model/lm/an4/an4.ctl`.wdseg src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.align.wdseg | grep SUCCESS > /dev/null 2>&1); \
then echo "ALIGN cepext wdseg test PASSED"; else \
echo "ALIGN cepext wdseg test FAILED"; fi 
if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl `head -1 src/tests/regression/../../../model/lm/an4/an4.ctl`.phseg src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test.align.phseg | grep SUCCESS > /dev/null 2>&1 ); \
then echo "ALIGN cepext phseg test PASSED"; else \
echo "ALIGN cepext phseg test FAILED"; fi 

tar cf test-align-cepext.tar $tmpout `head -1 src/tests/regression/../../../model/lm/an4/an4.ctl`.wdseg `head -1 src/tests/regression/../../../model/lm/an4/an4.ctl`.phseg
