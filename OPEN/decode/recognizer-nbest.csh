test -e ./wav/test1.wav    && rm ./wav/test1.wav 
test -e ./feat/test1.mfc   && rm ./feat/test1.mfc
test -e ./Out_lattice1/*.* && rm ./Out_lattice1/*.*
test -e ./Out_nbest1/*.*   && rm ./Out_nbest1/*.*

mkdir -p ./Out_lattice1
mkdir -p ./Out_nbest1
mkdir -p ./wav
mkdir -p ./feat
cp $1 ./wav/test1.wav
echo 'test1' > ../etc/test.fileids

#for converting wav to feature mfc
sphinx_fe  -mswav yes -i ./wav/test1.wav -o ./feat/test1.mfc >/dev/null 2>&1
#sphinx_fe  -samprate 8000.0 -mswav yes -nfilt 31 -lowerf 200 -upperf 3500 -i ./wav/test1.wav -o ./feat/test1.mfc

#./wave2feat -samprate 8000.0 -mswav 1 -dither yes -i ./wav/test1.wav -o ./feat/test1.mfc

#sphinx3_decode -cepdir ./feat -ctl ../etc/test.fileids -hyp hypo_open_test_fake-graphem_nbest.1f  -logfn open_fake.graphem-nbest.1f.log 	-dict ../etc/open.grapheme.dic -fdict  ../etc/open.filler -lm ../etc/open.lm.DMP -hmm  ../backup/backup-grapheme/model_parameters/open.cd_cont_200_4  -wip 0.2 -lw 2 

#recognize and generate many hyperthesis (lattice) per input mfc
sphinx3_decode -cepdir ./feat -ctl ../etc/test.fileids -hyp hypo_open_test_fake-graphem.f1 -logfn open_fake.graphem.f1.log 	-dict ../etc/open.grapheme.dic -fdict  ../etc/open.filler -lm ../etc/open.lm.DMP -hmm  ../backup/backup-grapheme/model_parameters/open.cd_cont_200_4  -wip 0.2 -lw 2 -outlatfmt 0 -latext SLF -outlatdir ./Out_lattice1 >/dev/null 2>&1

#generate first XX best hypothesis (-nbest XX) from lattice 
sphinx3_astar -ctl ../etc/test.fileids   -logfn open_fake.graphem-nbest.1f.log 	-dict ../etc/open.grapheme.dic -fdict  ../etc/open.filler -lm ../etc/open.lm.DMP  -mdef ../backup/backup-grapheme/model_parameters/open.cd_cont_200_4/mdef -latext SLF -inlatdir ./Out_lattice1 -nbest 3 -nbestext nbest -nbestdir ./Out_nbest1 -wip 0.2 -lw 2 >/dev/null 2>&1

#cat ./Out_nbest1/test1.nbest

#export format Json
#./export_json.csh
php to_json.php ./Out_nbest1/test1.nbest
