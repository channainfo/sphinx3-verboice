#!/bin/sh

tmpout="test-wave2feat-dither-seed.out"

# Run wave2feat with dither and seed, so it is repeatable. There's
# nothing special about the seed. Just chose it because it's pretty
echo "WAVE2FEAT-DITHER-SEED TEST"
sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/wave2feat \
-dither 1 \
-seed 1234 \
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
-o test-wave2feat-dither-seed.mfc.out  \
-raw 1 > $tmpout 2>&1 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/cepview \
-i 13 \
-d 13 \
-f test-wave2feat-dither-seed.mfc.out \
> test-wave2feat-dither-seed.cepview.out

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl test-wave2feat-dither-seed.cepview.out src/tests/regression/../../../model/ep/chan3-dither.cepview | grep SUCCESS > /dev/null 2>&1) ; \
then echo "WAVE2FEAT-DITHER-SEED test PASSED"; else \
echo "WAVE2FEAT-DITHER-SEED test FAILED"; fi

