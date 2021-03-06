SUBDIRS = src \
	doc \
	scripts \
	model \
	include

EXTRA_DIST = autogen.sh \
	programs.dsw \
	src/programs/main_livedecode.c \
	win32/batch/an4.ctl \
	win32/batch/sphinx3-simple.bat \
	win32/batch/sphinx3-test.align.bat \
	win32/batch/sphinx3-test.all.bat \
	win32/batch/sphinx3-test.allphone.bat \
	win32/batch/sphinx3-test.astar.bat \
	win32/batch/sphinx3-test.bat \
	win32/batch/sphinx3-test.dag.bat \
	win32/batch/sphinx3-test.decode.bat \
	win32/batch/sphinx3-test.ep.bat \
	win32/batch/sphinx3-test.gausubvq.bat \
	win32/batch/sphinx3-test.livepretend.bat \
	win32/batch/sphinx3-test.simple.bat \
	win32/mrcp.nsi \
	win32/msdev/libs3audio/libs3audio.dsp \
	win32/msdev/libs3decoder/libam.dsp \
	win32/msdev/libs3decoder/libAPI.dsp \
	win32/msdev/libs3decoder/libcep_feat.dsp \
	win32/msdev/libs3decoder/libcommon.dsp \
	win32/msdev/libs3decoder/libconfidence.dsp \
	win32/msdev/libs3decoder/libdict.dsp \
	win32/msdev/libs3decoder/libep.dsp \
	win32/msdev/libs3decoder/liblm.dsp \
	win32/msdev/libs3decoder/libsearch.dsp \
	win32/msdev/libutil/libutil.dsp \
	win32/msdev/programs/align/sphinx3_align.dsp \
	win32/msdev/programs/allphone/sphinx3_allphone.dsp \
	win32/msdev/programs/astar/sphinx3_astar.dsp \
	win32/msdev/programs/cepview/cepview.dsp \
	win32/msdev/programs/conf/sphinx3_conf.dsp \
	win32/msdev/programs/dag/sphinx3_dag.dsp \
	win32/msdev/programs/decode/sphinx3_decode.dsp \
	win32/msdev/programs/decode_anytopo/sphinx3_decode_anytopo.dsp \
	win32/msdev/programs/dp/sphinx3_dp.dsp \
	win32/msdev/programs/ep/sphinx3_ep.dsp \
	win32/msdev/programs/gausubvq/gausubvq.dsp \
	win32/msdev/programs/livedecode/sphinx3_livedecode.dsp \
	win32/msdev/programs/livepretend/sphinx3_livepretend.dsp \
	win32/msdev/programs/lm_convert/lm_convert.dsp \
	win32/msdev/programs/sphinx3_continuous/sphinx3_continuous.dsp

# Add an item for each and every test target to the CLEANFILES variable
CLEANFILES = chan3.mfc \
	test.out \
	test-*.cepview \
	test-*.log \
	test-*.mfc \
	test-*.log \
	test-*.out \
	test-*.seg \
	test-*.tar \
	test-*.hypseg \
	test-*.confhypseg \
	tmp.out \
	pittsburgh.* \
	tmp \
	test-align-mllr.log \
	allphone.match \
	allphone.matchseg \
	test-decode-mode2.match \
	test-lm_convert.* \
	test-lm_convert-and-decode.*

etags:
	etags `find . -name "*.[ch]"`

ctags:
	ctags `find . -name "*.[ch]"`

doxygen: 
	doxygen ./doc/doxygen.cfg

#######################################################################
#Session of testing
#######################################################################


# Override the Automake target so that make test-full gets run during
# distcheck
check: test-full
	@:

test-full : \
	test-decode-simple \
	test-decode \
	test-decode-clm \
	test-decode-mllr \
	test-decode-s3cont \
	test-decode-mode2 \
	test-decode-s2semi \
	test-decode-lts \
	test-decode-mode3 \
	test-decode-mode3-mulmpx \
	test-decode-mode3-mpx \
	test-decode-2ndstage \
	test-decode-mode1368 \
	test-decode-mode1369 \
	test-lm_convert-and-decode \
	test-dp \
	test-align \
	test-align-mllr \
	test-allphone \
	test-allphone-mllr \
	test-livepretend \
	test-livepretend-clm \
	test-livepretend-mllr \
	test-lm_convert \
	test-astar \
	test-astar-clm \
	test-dag \
	test-dag-clm \
	test-gausubvq \
	test-ep \
	test-cepview \
	test-conf \
	test-decode_anytopo \
	test-decode_anytopo-mllr \
	test-decode_anytopo-2ndstage \
	test-wave2feat \
	test-wave2feat-dither-seed \
	test-wave2feat-dither-rand \
	test-wave2feat-logspec

#	test-decode-noncomp \
#	test-decode-mode5 \
#	test-decode-mode5-noncomp 

test-all-app : test-full test-wave2feat


test-lm_convert-and-decode \
test-decode_anytopo-2ndstage \
test-decode_anytopo \
test-decode_anytopo-mllr \
test-decode-2ndstage \
test-decode \
test-decode-mode1368 \
test-decode-mode1369 \
test-decode-simple \
test-decode-noncomp \
test-decode-lts \
test-decode-mode2 \
test-decode-mode3 \
test-decode-mode3-mulmpx \
test-decode-mode3-mpx \
test-decode-mode5 \
test-decode-mode5-noncomp \
test-decode-s3cont \
test-decode-s2semi \
test-decode-clm \
test-decode-mllr \
test-dp \
test-align \
test-align-mllr \
test-allphone \
test-allphone-mllr \
test-astar \
test-astar-clm \
test-cepview \
test-conf \
test-dag \
test-dag-clm \
test-lm_convert \
test-livepretend \
test-livepretend-clm \
test-livepretend-mllr \
test-gausubvq \
test-ep \
test-wave2feat \
test-wave2feat-dither-seed \
test-wave2feat-dither-rand \
test-wave2feat-logspec:
	sh $(top_builddir)/src/tests/regression/$@.sh


perf-std : 
	make -C $(top_srcdir)/src/tests/performance/ti46 ti46-lp ti46-decode ti46-decany
	make -C $(top_srcdir)/src/tests/performance/tidigits tidigits-lp tidigits-decode  
	make -C $(top_srcdir)/src/tests/performance/Communicator com-fast-lp com-fast-decode
	make -C $(top_srcdir)/src/tests/performance/Communicator com-2stage-decode com-2stage-decany

perf-std-s3 : 
	make -C $(top_srcdir)/src/tests/performance/ti46 ti46-decany
	make -C $(top_srcdir)/src/tests/performance/tidigits tidigits-decany
	make -C $(top_srcdir)/src/tests/performance/Communicator com-base-decany

perf-full:	
	make -C $(top_srcdir)/src/tests/performance/ti46 quick slow
	make -C $(top_srcdir)/src/tests/performance/tidigits quick slow
	make -C $(top_srcdir)/src/tests/performance/rm1 lp
	make -C $(top_srcdir)/src/tests/performance/Communicator base fast
	make -C $(top_srcdir)/src/tests/performance/wsj5k lp decode decany
	make -C $(top_srcdir)/src/tests/performance/ICSI base


#	make -C $(top_srcdir)/src/tests/performance/spoke3 decode decany

perf-quick:	
	make -C $(top_srcdir)/src/tests/performance/ti46 quick slow
	make -C $(top_srcdir)/src/tests/performance/tidigits quick

perf-slow:	
	make -C $(top_srcdir)/src/tests/performance/ti46 slow
	make -C $(top_srcdir)/src/tests/performance/tidigits slow
	make -C $(top_srcdir)/src/tests/performance/rm1 lp
	make -C $(top_srcdir)/src/tests/performance/Communicator base
	make -C $(top_srcdir)/src/tests/performance/wsj5k lp decode decany
	make -C $(top_srcdir)/src/tests/performance/ICSI base

#	make -C $(top_srcdir)/src/tests/performance/spoke3 decode decany


#Cannot not be used because libtool will confuse valgrind.  Need to figure out later. 
#test-valgrind:
#	@echo "LIVEPRETEND TEST"
#	@echo "YOU SHOULD SEE THE RECOGNITION RESULT 'P I T T S B U R G H'"
#
#	$(LIBTOOL) --mode=execute valgrind --skin=memcheck src/programs/livepretend \
#		model/lm/an4/an4.ctl \
#		$(top_srcdir)/model/lm/an4 \
#		model/lm/an4/args.an4.test > $@.out 2>&1 
#	@grep "FWDVIT" $@.out 
#	@grep "FWDXCT" $@.out 

