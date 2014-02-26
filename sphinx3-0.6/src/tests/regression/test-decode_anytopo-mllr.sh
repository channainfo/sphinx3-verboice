#!/bin/sh

echo "DECODE_ANYTOPO+MLLR TEST"
echo "YOU SHOULD SEE THE RECOGNITION RESULT 'P I T T S B U R G H'"

tmpout="test-decode_anytopo-mllr.out"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_decode_anytopo \
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
-feat 1s_c_d_dd \
-lw 9.5 \
-wip 0.2 \
-beam 1e-80 \
-wbeam 1e-40 \
> $tmpout 2>&1
	
grep "FWDVIT" $tmpout
grep "FWDXCT" $tmpout

if (grep "FWDVIT" $tmpout |grep "P I T T S B U R G H" >/dev/null 2>&1) ; \
then echo "DECODE_ANYTOPO+MLLR test PASSED" ; else 
echo "DECODE_ANYTOPO+MLLR test FAILED" ; fi
