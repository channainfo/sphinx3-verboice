#!/bin/sh

tmpout="test-wave2feat-logspec.out"

echo "WAVE2FEAT-LOGSPEC TEST"
sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/wave2feat \
-logspec 1 \
-samprate 11025 \
-frate 105 \
-wlen 0.024 \
-alpha 0.97 \
-nfft 512 \
-nfilt 36 \
-upperf 5400 \
-lowerf 130 \
-blocksize 262500 \
-i src/tests/regression/../../../model/ep/chan3.raw \
-o test-wave2feat-logspec.mfc.out  \
-raw 1 > $tmpout 2>&1 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/cepview \
-i 40 \
-d 40 \
-f test-wave2feat-logspec.mfc.out \
> test-wave2feat-logspec.cepview.out

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl test-wave2feat-logspec.cepview.out src/tests/regression/../../../model/ep/chan3-logspec.cepview | grep SUCCESS > /dev/null 2>&1) ; \
then echo "WAVE2FEAT-LOGSPEC test PASSED"; else \
echo "WAVE2FEAT-LOGSPEC test FAILED"; fi

