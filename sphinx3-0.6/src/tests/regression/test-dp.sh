#!/bin/sh

echo "DP TEST"
tmpout="test-dp.out"

echo "TEST THE WORD ALIGNMENT ROUTINE. "

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_dp \
-hypfile src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/test.dp.hyp \
-reffile src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/test.dp.ref \
> $tmpout 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpout src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/test.dp.simple.log | grep SUCCESS > /dev/null 2>&1); \
then echo "DP SIMPLE test PASSED"; else \
echo "DP SIMPLE test FAILED"; fi 

#sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_dp \
#-d 1 \
#-hypfile src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/test.dp.hyp \
#-reffile src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/test.dp.ref \
#> $tmpout

#if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpout src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/test.dp.detail.log | grep SUCCESS > /dev/null 2>&1); \
#then echo "DP DETAIL test PASSED"; else \
#echo "DP DETAIL test FAILED"; fi 

