#!/bin/sh

# (README BEFORE YOU CHANGE THIS TEST) ARCHAN: 
# This is perhaps the most important test for the decoder because the argument specified
# is the smallest set that one could use the decoder. 
#
# If your change happened to break this test and what you will need is to **augment** argument
# to this test.  That is to say what you did is not conform to the design of the recognizer. 
# Please re-consider before you apply your change. 
#
# Why the current set is the minimal? Consider this.  An hmm-based speech recognizer essentially
# just required 4 information to start the decoder. 
# 1, The waveform input.
# 2, The graph which could be an LM or an FSG. 
# 3, The dictionary. 
# 4, The HMM. 
#
# So, the 6 arguments we used are already too many. :-)
# The answer fo the code is not the P I T T S B U R G H. It will be P I T G S B U R G H

tmpout="test-decode-simple.out"

echo "DECODE SIMPLE TEST"

#sh  src/tests/regression/../../.././libtool --mode=execute cp src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/hub4opensrc.6000.mdef src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/mdef

margs="-hmm src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/ \
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-lm src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl \
-cepdir src/tests/regression/../../../model/lm/an4/ "

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_decode $margs > $tmpout 2>&1
grep "FWDVIT" $tmpout
grep "FWDXCT" $tmpout

if(grep "FWDVIT" $tmpout |grep "P I T G S B U R G H" > /dev/null 2>&1); \
then echo "DECODE SIMPLE test PASSED" ; else \
echo "DECODE SIMPLE test FAILED" ; fi



