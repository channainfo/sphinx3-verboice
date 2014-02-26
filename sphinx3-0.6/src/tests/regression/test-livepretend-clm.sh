#!/bin/sh

echo "LIVEPRETEND CLASS-BASED LM TEST"
echo "YOU SHOULD SEE THE RECOGNITION RESULT 'P I T T S B U R G H'"

tmpout="test-livepretend-clm.out"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_livepretend \
src/tests/regression/../../../model/lm/an4/an4.ctl \
src/tests/regression/../../../model/lm/an4 \
src/tests/regression/../../.././model/lm/an4/args.an4.test.cls > $tmpout 2>&1

grep "FWDVIT" $tmpout
grep "FWDXCT" $tmpout

if (grep "FWDVIT" $tmpout |grep "P I T T S B U R G H" >/dev/null 2>&1) ; \
then echo "LIVEPRETEND CLASS-BASED LM test PASSED" ; else 
echo "LIVEPRETEND CLASS-BASED LM test FAILED" ; fi

