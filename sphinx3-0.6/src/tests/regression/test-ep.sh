#!/bin/sh

echo "EP TEST"
tmplog="test-ep.log"
tmpout="test-ep.out"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_ep \
-i src/tests/regression/../../../model/ep/chan3.raw  \
-samprate 11025 \
-frate 105 \
-wlen 0.024 \
-alpha 0.97 \
-ncep 13 \
-nfft 512 \
-nfilt 36 \
-upperf 5400 \
-lowerf 130 \
-blocksize 262500 \
-mdef src/tests/regression/../../../model/ep/ep.mdef \
-mean src/tests/regression/../../../model/ep/means \
-var src/tests/regression/../../../model/ep/variances \
-mixw src/tests/regression/../../../model/ep/mixture_weights \
-raw 1 \
> $tmplog 2>&1

grep "Utt_" $tmplog > $tmpout
if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpout src/tests/regression/../../../model/ep/ep.result | grep SUCCESS > /dev/null 2>&1); \
then echo "EP test PASSED"; else \
echo "EP test FAILED"; fi 
