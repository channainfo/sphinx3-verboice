#!/bin/sh

echo "CEPVIEW TEST"
tmpout="test-cepview.out"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/cepview \
-i 13 \
-d 13 \
-f src/tests/regression/../../../model/ep/chan3.mfc \
> $tmpout
if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpout src/tests/regression/../../../model/ep/chan3.cepview | grep SUCCESS > /dev/null 2>&1); \
then echo "CEPVIEW test PASSED"; else \
echo "CEPVIEW test FAILED"; fi 
