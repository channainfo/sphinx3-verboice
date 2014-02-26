#!/bin/sh

tmpout="test-wave2feat.out"

echo "WAVE2FEAT TEST"
sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/wave2feat \
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
-i src/tests/regression/../../../model/ep/chan3.raw \
-o test-wave2feat.mfc  \
-raw 1 > $tmpout 2>&1 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/cepview \
-i 13 \
-d 13 \
-f test-wave2feat.mfc \
> test-wave2feat.cepview

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl test-wave2feat.cepview src/tests/regression/../../../model/ep/chan3.cepview | grep SUCCESS > /dev/null 2>&1) ; \
then echo "WAVE2FEAT test PASSED"; else \
echo "WAVE2FEAT test FAILED"; fi

