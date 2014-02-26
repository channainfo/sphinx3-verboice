#!/bin/sh

tmpout="test-wave2feat-dither-rand.out"

echo "WAVE2FEAT-DITHER-RAND TEST"
sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/wave2feat \
-dither 1 \
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
-o test-wave2feat-dither-rand.mfc.out  \
-raw 1 > $tmpout 2>&1 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/cepview \
-i 13 \
-d 13 \
-f test-wave2feat-dither-rand.mfc.out \
> test-wave2feat-dither-rand.cepview.out

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl test-wave2feat-dither-rand.cepview.out src/tests/regression/../../../model/ep/chan3-dither.cepview | grep SUCCESS > /dev/null 2>&1) ; \
then echo "WAVE2FEAT-DITHER-RAND test FAILED"; else \
if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl test-wave2feat-dither-rand.cepview.out src/tests/regression/../../../model/ep/chan3-dither.cepview 0.2 | grep SUCCESS > /dev/null 2>&1) ; \
then echo "WAVE2FEAT-DITHER-RAND test PASSED"; else \
echo "WAVE2FEAT-DITHER-RAND test FAILED"; fi; \
fi

