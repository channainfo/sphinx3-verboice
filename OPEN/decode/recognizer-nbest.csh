#test -e ./wav/test1.wav    && rm ./wav/test1.wav 
#test -e ./feat/test1.mfc   && rm ./feat/test1.mfc
#test -e ./Out_lattice1/*.* && rm ./Out_lattice1/*.*
#test -e ./Out_nbest1/*.*   && rm ./Out_nbest1/*.*

mkdir -p ./Out_lattice1
mkdir -p ./Out_nbest1
mkdir -p ./wav
mkdir -p ./feat

path=$1
filepath=${path##*/}
filename="$2_${filepath%.wav}"

cp $1 ./wav/$filename.wav
echo $filename > ../etc/$filename.fileids


sphinx_fe -samprate 8000.0 -mswav yes -nfilt 31 -lowerf 200 -upperf 3500 -i ./wav/$filename.wav -o ./feat/$filename.mfc >/dev/null 2>&1

#recognize and generate many hyperthesis (lattice) per input mfc
sphinx3_decode -cepdir ./feat -ctl ../etc/$filename.fileids -hyp hypo_open_test_fake-graphem.f1 -logfn open_fake.graphem.f1.log -dict ../etc/open.grapheme.dic -fdict  ../etc/open.filler -lm ../etc/open.lm.DMP -hmm  ../backup/backup-grapheme/model_parameters/open.cd_cont_200_4  -wip 0.2 -lw 1 -outlatfmt 0 -latext SLF -outlatdir ./Out_lattice1 >/dev/null 2>&1

#generate first XX best hypothesis (-nbest XX) from lattice 
sphinx3_astar -ctl ../etc/$filename.fileids   -logfn open_fake.graphem-nbest.1f.log 	-dict ../etc/open.grapheme.dic -fdict  ../etc/open.filler -lm ../etc/open.lm.DMP  -mdef ../backup/backup-grapheme/model_parameters/open.cd_cont_200_4/mdef -latext SLF -inlatdir ./Out_lattice1 -nbest 5 -nbestext nbest -nbestdir ./Out_nbest1 -wip 0.2 -lw 1 >/dev/null 2>&1

#cat ./Out_nbest1/$filename.nbest

#export format Json
php to_json.php ./Out_nbest1/$filename.nbest
