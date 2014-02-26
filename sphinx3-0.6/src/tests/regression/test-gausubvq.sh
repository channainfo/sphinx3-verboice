#!/bin/sh

echo "GAUSUBVQ TEST"
tmplog="test-gausubvq.log"
tmpout="test-gausubvq.out"

echo "This will compare the answer with a pre-generated svq file"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/gausubvq \
-mean src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/means \
-var  src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/variances \
-mixw  src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/mixture_weights \
-svspec 0-38 \
-iter 20 \
-svqrows 16 \
-seed 1111 \
-subvq $tmplog

grep -v "#" $tmplog > $tmpout
if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpout src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/test.subvq | grep SUCCESS > /dev/null 2>&1); \
then echo "GAUSUBVQ test PASSED"; else \
echo "GAUSUBVQ test FAILED"; fi 
