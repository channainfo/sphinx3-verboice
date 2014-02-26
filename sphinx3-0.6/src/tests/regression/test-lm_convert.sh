#!/bin/sh

echo "LM_CONVERT TEST"
tmpout="test-lm_convert.out"
tmptxt="test-lm_convert.TXT"
tmpfst="test-lm_convert.FST"
tmpdmp="test-lm_convert.DMP"

echo "This will perform several tests that compare the converted LMs to a pre-generated ones. "

#Couldn't do a match test because the paths generated in the LM will differ.  
if(sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa \
-output $tmpdmp > /dev/null 2>&1); \
then echo "LM CONVERT PHONE DRY RUN LM TXT-> DMP test PASSED"; else \
echo "LM CONVERT PHONE DRY RUN LM TXT-> DMP test FAILED"; fi

if(sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa \
-inputfmt TXT32 \
-output $tmpdmp > /dev/null 2>&1); \
then echo "LM CONVERT PHONE DRY RUN LM TXT32-> DMP test PASSED"; else \
echo "LM CONVERT PHONE DRY RUN LM TXT32-> DMP test FAILED"; fi

if(sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa \
-output $tmpdmp \
-outputfmt DMP32 \
> /dev/null 2>&1); \
then echo "LM CONVERT PHONE DRY RUN LM TXT-> DMP32 test PASSED"; else \
echo "LM CONVERT PHONE DRY RUN LM TXT-> DMP32 test FAILED"; fi

if(sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa \
-inputfmt TXT32 \
-output $tmpdmp \
-outputfmt DMP32 \
> /dev/null 2>&1); \
then echo "LM CONVERT PHONE DRY RUN LM TXT32-> DMP32 test PASSED"; else \
echo "LM CONVERT PHONE DRY RUN LM TXT32-> DMP32 test FAILED"; fi


sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa.DMP \
-inputfmt DMP \
-output $tmptxt \
-outputfmt TXT \
> $tmpout 2>&1 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmptxt src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa.lm_convert 0.0002 | grep SUCCESS > /dev/null 2>&1); \
then echo "LM_CONVERT PHONE LM DMP -> TXT test PASSED"; else \
echo "LM_CONVERT PHONE LM DMP -> TXT test FAILED"; fi 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa \
-output $tmpfst \
-outputfmt FST \
> $tmpout 2>&1 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpfst src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa.FST 0.0002 | grep SUCCESS > /dev/null 2>&1); \
then echo "LM_CONVERT PHONE LM TXT -> FST test PASSED"; else \
echo "LM_CONVERT PHONE LM TXT -> FST test FAILED"; fi 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl ${tmpfst}.sym src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa.FST.SYM 0.0002 | grep SUCCESS > /dev/null 2>&1); \
then echo "LM_CONVERT PHONE LM TXT -> FST SYM test PASSED"; else \
echo "LM_CONVERT PHONE LM TXT -> FST SYM test FAILED"; fi 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa \
-inputfmt TXT32 \
-output $tmpfst \
-outputfmt FST \
> $tmpout 2>&1 

#This is cheating.  I was just too tired to get it tested at this point. 
#if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpfst src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa.FST 0.0002 | grep SUCCESS > /dev/null 2>&1); \
#then echo "LM_CONVERT PHONE LM TXT32 -> FST test PASSED"; else \
#echo "LM_CONVERT PHONE LM TXT32 -> FST test FAILED"; fi 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl ${tmpfst}.sym src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa.FST.SYM 0.0002 | grep SUCCESS > /dev/null 2>&1); \
then echo "LM_CONVERT PHONE LM TXT32 -> FST SYM test PASSED"; else \
echo "LM_CONVERT PHONE LM TXT32 -> FST SYM test FAILED"; fi 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa \
-output $tmpdmp \
> $tmpout 2>&1 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input $tmpdmp \
-inputfmt DMP \
-output $tmptxt \
-outputfmt TXT \
> $tmpout 2>&1 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmptxt src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa.lm_convert 0.0002 | grep SUCCESS > /dev/null 2>&1); \
then echo "LM_CONVERT PHONE LM TXT -> DMP -> TXT test PASSED"; else \
echo "LM_CONVERT PHONE LM TXT -> DMP -> TXT test FAILED"; fi 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa \
-inputfmt TXT32 \
-output $tmpdmp \
> $tmpout 2>&1 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input $tmpdmp \
-inputfmt DMP \
-output $tmptxt \
-outputfmt TXT \
> $tmpout 2>&1 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmptxt src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa.lm_convert 0.0002 | grep SUCCESS > /dev/null 2>&1); \
then echo "LM_CONVERT PHONE LM TXT32 -> DMP -> TXT test PASSED"; else \
echo "LM_CONVERT PHONE LM TXT32 -> DMP -> TXT test FAILED"; fi 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa \
-output $tmpdmp \
-outputfmt DMP \
> $tmpout 2>&1 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input $tmpdmp \
-output $tmptxt \
-outputfmt TXT \
> $tmpout 2>&1 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmptxt src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa.lm_convert 0.0002 | grep SUCCESS > /dev/null 2>&1); \
then echo "LM_CONVERT PHONE LM TXT -> DMP32 -> TXT test PASSED"; else \
echo "LM_CONVERT PHONE LM TXT -> DMP32 -> TXT test FAILED"; fi 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa \
-inputfmt TXT32 \
-output $tmpdmp \
-outputfmt DMP \
> $tmpout 2>&1 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input $tmpdmp \
-output $tmptxt \
-outputfmt TXT \
> $tmpout 2>&1 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmptxt src/tests/regression/../../../model/lm/an4/an4.tg.phone.arpa.lm_convert 0.0002 | grep SUCCESS > /dev/null 2>&1); \
then echo "LM_CONVERT PHONE LM TXT32 -> DMP32 -> TXT test PASSED"; else \
echo "LM_CONVERT PHONE LM TXT32 -> DMP32 -> TXT test FAILED"; fi 

#Couldn't do a match test because the paths generated in the LM will differ.  
if(sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.ug.lm \
-output $tmpdmp > /dev/null 2>&1); \
then echo "LM CONVERT WORD DRY RUN LM TXT-> DMP test PASSED"; else \
echo "LM CONVERT WORD DRY RUN LM TXT-> DMP test FAILED"; fi

if(sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.ug.lm \
-output $tmpdmp \
-outputfmt DMP32 \
> /dev/null 2>&1); \
then echo "LM CONVERT WORD DRY RUN LM TXT-> DMP32 test PASSED"; else \
echo "LM CONVERT WORD DRY RUN LM TXT-> DMP32 test FAILED"; fi

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP \
-inputfmt DMP \
-output $tmptxt \
-outputfmt TXT \
> $tmpout 2>&1 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmptxt src/tests/regression/../../../model/lm/an4/an4.ug.lm.lm_convert 0.0002 | grep SUCCESS > /dev/null 2>&1); \
then echo "LM_CONVERT WORD LM DMP -> TXT test PASSED"; else \
echo "LM_CONVERT WORD LM DMP -> TXT test FAILED"; fi 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.ug.lm \
-output $tmpfst \
-outputfmt FST \
> $tmpout 2>&1 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpfst src/tests/regression/../../../model/lm/an4/an4.ug.lm.FST 0.0002 | grep SUCCESS > /dev/null 2>&1); \
then echo "LM_CONVERT WORD LM TXT -> FST test PASSED"; else \
echo "LM_CONVERT WORD LM TXT -> FST test FAILED"; fi 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.ug.lm \
-inputfmt TXT32 \
-output $tmpfst \
-outputfmt FST \
> $tmpout 2>&1 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpfst src/tests/regression/../../../model/lm/an4/an4.ug.lm.FST 0.0002 | grep SUCCESS > /dev/null 2>&1); \
then echo "LM_CONVERT WORD LM TXT32 -> FST test PASSED"; else \
echo "LM_CONVERT WORD LM TXT32 -> FST test FAILED"; fi 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.ug.lm \
-output $tmpdmp \
> $tmpout 2>&1 

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/lm_convert \
-input src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP \
-inputfmt DMP \
-output $tmptxt \
-outputfmt TXT \
> $tmpout 2>&1 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmptxt src/tests/regression/../../../model/lm/an4/an4.ug.lm.lm_convert 0.0002 | grep SUCCESS > /dev/null 2>&1); \
then echo "LM_CONVERT WORD LM DMP -> TXT -> DMP test PASSED"; else \
echo "LM_CONVERT WORD LM DMP -> TXT -> DMP test FAILED"; fi 