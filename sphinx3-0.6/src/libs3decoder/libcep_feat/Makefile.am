ARCH   = `uname -m | sed s/i.86/i386/`_`uname -s | tr A-Z a-z`

noinst_LTLIBRARIES = libcep_feat.la


libcep_feat_la_LDFLAGS = -version-info 0:6:0

libcep_feat_la_SOURCES = \
	agc.c \
	cmn.c \
	cmn_prior.c \
	fe.c \
	fe_interface.c \
	fe_sigproc.c \
	fe_warp.c \
	fe_warp_affine.c \
	fe_warp_inverse_linear.c \
	fe_warp_piecewise_linear.c \
	feat.c

noinst_HEADERS = \
	fe_internal.h \
	fe_warp.h \
	fe_warp_affine.h \
	fe_warp_inverse_linear.h \
	fe_warp_piecewise_linear.h


INCLUDES = -I$(top_srcdir)/include \
           -I$(top_builddir)/include 

LIBOBJS = @LIBOBJS@

