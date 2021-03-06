#!/bin/sh

tmpout="test-lm_convert-and-decode.out"

echo "LM CONVERT DMP  -> DECODE TEST"
echo "YOU SHOULD SEE THE RECOGNITION RESULT 'P I T T S B U R G H'"

tmpdmp="test-lm_convert-and-decode.DMP"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.ug.lm \
-output $tmpdmp \
-outputfmt DMP \
> /dev/null 2>&1

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
-ds 2 \
-tighten_factor 0.4"

lmargs="-lm $tmpdmp"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_decode $margs $lmargs > $tmpout 2>&1
grep "FWDVIT" $tmpout
grep "FWDXCT" $tmpout

if(grep "FWDVIT" $tmpout |grep "P I T T S B U R G H" > /dev/null 2>&1); \
then echo "LM_CONVERT DMP -> DECODE test PASSED" ; else \
echo "LM_CONVERT DMP -> DECODE test FAILED" ; fi


echo "LM CONVERT DMP32  -> DECODE TEST"
echo "YOU SHOULD SEE THE RECOGNITION RESULT 'P I T T S B U R G H'"

tmpdmp="test-lm_convert-and-decode.DMP32"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.ug.lm \
-output $tmpdmp \
-outputfmt DMP32 \
> /dev/null 2>&1

lmargs="-lm $tmpdmp"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_decode $margs $lmargs > $tmpout 2>&1
grep "FWDVIT" $tmpout
grep "FWDXCT" $tmpout

if(grep "FWDVIT" $tmpout |grep "P I T T S B U R G H" > /dev/null 2>&1); \
then echo "LM_CONVERT DMP32 -> DECODE test PASSED" ; else \
echo "LM_CONVERT DMP32 -> DECODE test FAILED" ; fi

echo "TXT LM  -> DECODE TEST"
echo "YOU SHOULD SEE THE RECOGNITION RESULT 'P I T T S B U R G H'"

lmargs="-lm src/tests/regression/../../../model/lm/an4/an4.ug.lm -lminmemory 1"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_decode $margs $lmargs > $tmpout 2>&1
grep "FWDVIT" $tmpout
grep "FWDXCT" $tmpout

if(grep "FWDVIT" $tmpout |grep "P I T T S B U R G H" > /dev/null 2>&1); \
then echo "TXT LM  -> DECODE test PASSED" ; else \
echo "TXT LM -> DECODE test FAILED" ; fi

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.ug.lm \
-inputfmt TXT32 \
-output $tmpdmp \
> /dev/null 2>&1

lmargs="-lm $tmpdmp"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_decode $margs $lmargs > $tmpout 2>&1
grep "FWDVIT" $tmpout
grep "FWDXCT" $tmpout

if(grep "FWDVIT" $tmpout |grep "P I T T S B U R G H" > /dev/null 2>&1); \
then echo "LM_CONVERT FRO TXT32 -> DECODE test PASSED" ; else \
echo "LM_CONVERT FRO TXT32 -> DECODE test FAILED" ; fi

