ACLOCAL_AMFLAGS = -I m4
    SUBDIRS = libetorrent src
    EXTRA_DIST = autogen.sh

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = etorrent-0.1.pc

vapidir = $(datadir)/vala/vapi
dist_vapi_DATA = etorrent-0.1.deps

DISTCLEANFILES = aclocal.m4 ar-lib compile config.guess config.sub config.status configure \
	depcomp install-sh libtool ltmain.sh missing Makefile.in

distclean-local:
	rm -rf autom4te.cache
