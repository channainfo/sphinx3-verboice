#!/bin/sh

tmpout="test-decode-s2semi.out"

echo "DECODE SPHINX2 TEST"
echo "YOU SHOULD SEE THE RECOGNITION RESULT 'E I T G S B U R G H' (don't panic!)"

margs="-mdef src/tests/regression/../../../model/hmm/RM1_cd_semi/RM1.1000.mdef \
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-mean src/tests/regression/../../../model/hmm/RM1_cd_semi/means \
-var src/tests/regression/../../../model/hmm/RM1_cd_semi/variances \
-mixw src/tests/regression/../../../model/hmm/RM1_cd_semi/mixture_weights \
-tmat src/tests/regression/../../../model/hmm/RM1_cd_semi/transition_matrices \
-kdtree src/tests/regression/../../../model/hmm/RM1_cd_semi/kdtrees \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl \
-cepdir src/tests/regression/../../../model/lm/an4/ \
-senmgau .s2semi. \
-agc none \
-varnorm no \
-cmn current \
-ds 2 \
-lw 6.5 \
-feat s2_4x"

lmargs="-lm src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_decode $margs $lmargs > $tmpout 2>&1
grep "FWDVIT" $tmpout
grep "FWDXCT" $tmpout

if(grep "FWDVIT" $tmpout |grep "E I T G S B U R G H" > /dev/null 2>&1); \
then echo "DECODE SPHINX2 test PASSED" ; else \
echo "DECODE SPHINX2 test FAILED" ; fi



