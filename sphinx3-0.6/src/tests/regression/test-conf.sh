#!/bin/sh

tmpout="test-conf.out"
tmphypseg="test-conf.hypseg"
tmpconfhypseg="test-conf.confhypseg"

echo "DECODE -> CONFIDENCE TEST"

margs="-mdef src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/hub4opensrc.6000.mdef \
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-mean src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/means \
-var src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/variances \
-mixw src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/mixture_weights \
-tmat src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/transition_matrices \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl \
-cepdir src/tests/regression/../../../model/lm/an4/ \
-agc none \
-varnorm no \
-cmn current \
-subvqbeam 1e-02 \
-epl 4 \
-fillprob 0.02 \
-feat 1s_c_d_dd \
-lw 9.5 \
-maxwpf 1 \
-beam 1e-40 \
-pbeam 1e-30 \
-wbeam 1e-20 \
-maxhmmpf 1500 \
-wend_beam 1e-1 \
-ci_pbeam 1e-5 \
-ds 2 \
-tighten_factor 0.4 \
-outlatdir . \
-hypseg $tmphypseg \
"

lmargs="-lm src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_decode $margs $lmargs > $tmpout 2>&1

margs="-mdef src/tests/regression/../../../model/hmm/hub4_cd_continuous_8gau_1s_c_d_dd/hub4opensrc.6000.mdef \
-fdict src/tests/regression/../../../model/lm/an4/filler.dict \
-dict src/tests/regression/../../../model/lm/an4/an4.dict \
-inlatdir ./ \
-logbase 1.003 \
-ctl src/tests/regression/../../../model/lm/an4/an4.ctl \
-inhypseg $tmphypseg \
-output $tmpconfhypseg \
-lm src/tests/regression/../../../model/lm/an4/an4.ug.lm.DMP \
"

sh src/tests/regression/../../.././libtool --mode=execute src/tests/regression/../../.././src/programs/sphinx3_conf $margs >> $tmpout 2>&1 

if (perl src/tests/regression/../../../src/tests/regression/compare_table.pl $tmpconfhypseg src/tests/regression/../../../model/hmm//hub4_cd_continuous_8gau_1s_c_d_dd/test-conf.confhypseg 2 | grep SUCCESS > /dev/null 2>&1); \
then echo "DECODE -> CONF test PASSED"; else \
echo "DECODE -> CONF test FAILED"; fi 

