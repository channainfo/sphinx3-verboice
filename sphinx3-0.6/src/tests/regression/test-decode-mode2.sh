#!/bin/sh

tmpout="test-decode-mode2.out"
tmpmatch="test-decode-mode2.match"

echo "DECODE FSG TEST"

margs=" \
-mdef  src/tests/regression/../../../model/hmm/tidigits/wd_dependent_phone.500.mdef \
-dict src/tests/regression/../../../model/hmm/tidigits/dictionary \
-fdict  src/tests/regression/../../../model/hmm/tidigits/fillerdict \
-mean  src/tests/regression/../../../model/hmm/tidigits/wd_dependent_phone.cd_continuous_8gau/means.LittleEndian \
-var   src/tests/regression/../../../model/hmm/tidigits/wd_dependent_phone.cd_continuous_8gau/variances.LittleEndian \
-mixw  src/tests/regression/../../../model/hmm/tidigits/wd_dependent_phone.cd_continuous_8gau/mixture_weights.LittleEndian \
-tmat  src/tests/regression/../../../model/hmm/tidigits/wd_dependent_phone.cd_continuous_8gau/transition_matrices.LittleEndian \
-cepdir src/tests/regression/../../../model/hmm/tidigits/cepstra/ \
-hyp $tmpmatch \
-agc none \
-varnorm no \
-cmn current \
-lw 9.5 \
-op_mode 2 \
"

fsgargs=" \
-fsg src/tests/regression/../../../model/hmm/tidigits/test.digits.fsg \
-ctl src/tests/regression/../../../model/hmm/tidigits/tidigits.length.arb.regression \
"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_decode $margs $fsgargs > $tmpout 2>&1
                                  
if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpmatch src/tests/regression/../../../model/hmm/tidigits/tidigits.length.arb.result > /dev/null 2>&1); \
then echo "DECODE FSG ARBITRARY LENGTH DIGIT STRING test PASSED"; else \
echo "DECODE FSG ARBITRARY LENGTH DIGIT STRING test FAILED"; fi

fsgargs=" \
-fsg src/tests/regression/../../../model/hmm/tidigits/test.iso.digits.fsg \
-ctl src/tests/regression/../../../model/hmm/tidigits/tidigits.length.1.regression \
"

sh src/tests/regression/../../.././libtool --mode=execute @abs_top_builddir/src/programs/sphinx3_decode $margs $fsgargs > $tmpout 2>&1

if(perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpmatch src/tests/regression/../../../model/hmm/tidigits/tidigits.length.1.result > /dev/null 2>&1); \
then echo "DECODE FSG LENGTH 1 DIGIT (ISOLATED DIGIT) STRING test PASSED"; else \
echo "DECODE FSG LENGTH 1 DIGIT (ISOLATED DIGITS) STRING test FAILED"; fi

fsgargs=" \
-fsg src/tests/regression/../../../model/hmm/tidigits/test.2.digits.fsg \
-ctl src/tests/regression/../../../model/hmm/tidigits/tidigits.length.2.regression \
"

sh @abs_top_builddir/libtool --mode=execute @abs_top_builddir/src/programs/sphinx3_decode $margs $fsgargs > $tmpout 2>&1

if(perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpmatch @abs_top_srcdir/model/hmm/tidigits/tidigits.length.2.result > /dev/null 2>&1); \
then echo "DECODE FSG LENGTH 2 DIGIT STRING test PASSED"; else \
echo "DECODE FSG LENGTH 2 DIGIT STRING test FAILED"; fi
