# libs3audio: Audio Device interface for Sphinx-3

lib_LTLIBRARIES = libs3audio.la

libs3audio_la_LDFLAGS = -version-info 0:4:0

libs3audio_la_SOURCES = cont_ad_base.c

EXTRA_libs3audio_la_SOURCES = ad_base.c \
	pa_convert.c \
	pa_lib.c \
	pa_mac_core.c \
	pa_trace.c \
	pablio.c \
	ringbuffer.c \
	ad_oss.c \
	ad_oss_bsd.c \
	ad_alsa.c \
	ad_osf.c \
	ad_irix.c \
	ad_sunos.c \
	ad_portaudio.c \
	audio_utils_sunos.c \
	play_win32.c \
	rec_win32.c \
	mulaw_base.c \
	audio_utils_sunos.h \
	pa_host.h \
	pa_trace.h \
	pablio.h \
	portaudio.h \
	ringbuffer.h

pkginclude_HEADERS = ad_conf.h

libs3audio_la_DEPENDENCIES = @ad_files@

libs3audio_la_LIBADD = @ad_files@ @ad_libs@

INCLUDES = -I$(top_srcdir)/include \
	-I$(top_builddir)/include
