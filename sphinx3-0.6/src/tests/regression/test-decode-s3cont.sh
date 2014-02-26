#!/bin/sh

tmpout="test-decode-s3cont.out"

echo "DECODE S3CONT TEST"
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
-maxwpf 1 \
-beam 1e-40 \
-pbeam 1e-30 \
-wbeam 1e-20 \
-maxhmmpf 1500 \
-wend_beam 1e-1 \
-feat 1s_c_d_dd \
-senmgau .s3cont."

lmargs="-lm src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP"

clsargs="-lmctlfn src/tests/regression/../../../model/lm/an4/an4.ug.cls.lmctl \
-ctl_lm  src/tests/regression/../../../model/lm/an4/an4.ctl_lm" 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_decode $margs $lmargs > $tmpout 2>&1
grep "FWDVIT" $tmpout
grep "FWDXCT" $tmpout

#Seems to me a situation where, the decode cannot be tuned to P I T T
#S B U R G H in this case. Just try to run through it now. 

if(grep "FWDVIT" $tmpout |grep "P I T G S B U R G H" > /dev/null 2>&1); \
then echo "DECODE S3CONT test PASSED" ; else \
echo "DECODE S3CONT test FAILED" ; fi



