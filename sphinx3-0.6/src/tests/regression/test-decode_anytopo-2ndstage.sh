#!/bin/sh

echo "DECODE_ANYTOPO 2ND STAGE TEST"
echo "YOU SHOULD SEE THE RECOGNITION RESULT 'P I T T S B U R G H'"

tmpout="test-decode_anytopo-2ndstage.out"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_decode_anytopo \
-mdef src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/hub4opensrc.6000.mdef \
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-mean src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/means \
-var src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/variances \
-mixw src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/mixture_weights \
-tmat src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/transition_matrices \
-lm src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl \
-cepdir src/tests/regression/../../../model/lm/an4/ \
-agc none \
-varnorm no \
-cmn current \
-feat 1s_c_d_dd \
-lw 9.5 \
-wip 0.2 \
-beam 1e-80 \
-wbeam 1e-40 \
-outlatdir ./ \
-bestpath 1 \
-bestpathlw 6.5 \
> $tmpout 2>&1
	
grep "BSTPTH" $tmpout
grep "BSTXCT" $tmpout

if (grep "BSTPTH" $tmpout |grep "P I T T S B U R G H" >/dev/null 2>&1) ; \
then echo "DECODE_ANYTOPO 2ND STAGE test PASSED" ; else 
echo "DECODE_ANYTOPO 2ND STAGE test FAILED" ; fi

lmargs="-lm src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP"

#Next try to read the lattices with dag and see whether dag could read it. 

margs="-mdef src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/hub4opensrc.6000.mdef \
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-lw 13.0 \
-wip 0.2 \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl \
-inlatdir ./ \
-logbase 1.0003 \
-backtrace 1 "

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_dag $margs $lmargs > $tmpout 2>&1 

grep "BSTPTH:" $tmpout 
grep "BSTXCT" $tmpout 

if(grep "BSTPTH:" $tmpout |grep "P I T T S B U R G H" > /dev/null 2>&1); \
then echo "DAG after DECODE_ANYTOPO 1st stage test PASSED" ; else \
echo "DAG after DECODE_ANYTOPO 1st stage test FAILED" ; fi

#Next try to read the lattices with astar and see whether astar could read it. 

margs="-mdef src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/hub4opensrc.6000.mdef \
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-wip 0.2 \
-beam 1e-64 \
-nbest 5 \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl \
-inlatdir ./ \
-logbase 1.0003 \
-nbestdir .  "

if(sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_astar $margs $lmargs > $tmpout 2>&1); \
then echo "ASTAR after DECODE_ANYTOPO 1st stage dry run test PASSED"; else \
echo "ASTAR after DECODE_ANYTOPO 1st stage dry run test FAILED"; fi

#gzip -cfd ./`head -1 src/tests/regression/../../../model/lm/an4/an4.ctl`.nbest.gz > ./pittsburgh.nbest 
#if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl ./pittsburgh.nbest src/tests/regression/../../../model/lm/an4/pittsburgh.nbest | grep SUCCESS > /dev/null 2>&1); \
#then echo "ASTAR after DECODE_ANYTOPO 1st stage test PASSED"; else \
#echo "ASTAR after DECODE_ANYTOPO 1st stage test FAILED"; fi


