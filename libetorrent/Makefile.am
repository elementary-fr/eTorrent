AM_CPPFLAGS = $(LIBETORRENT_CFLAGS)

AM_CFLAGS = `pkg-config --cflags --libs libsoup-2.4 json-glib-1.0` \
	-w

lib_LTLIBRARIES = libetorrent.la

vapidir = $(datadir)/vala/vapi
dist_vapi_DATA = etorrent-0.1.vapi

libetorrentincludedir = $(includedir)
libetorrentinclude_HEADERS = libetorrent.h

libetorrent_la_SOURCES = session.vala error.vala torrent.vala torrent_file.vala peer.vala tracker.vala enums.vala
	
libetorrent_la_VALAFLAGS = --library libetorrent -H libetorrent.h --pkg libsoup-2.4 --pkg json-glib-1.0 \
	--vapi=etorrent-0.1.vapi --disable-warnings --gir ETorrent-0.1.gir

ETorrent-0.1.gir etorrent-0.1.vapi: libetorrent.la
	
if HAVE_INTROSPECTION
girdir = @INTROSPECTION_GIRDIR@

gir_DATA = \
	ETorrent-0.1.gir \
	$(NULL)

typelibdir = @INTROSPECTION_TYPELIBDIR@
typelib_DATA = \
	ETorrent-0.1.typelib \
	$(NULL)

ETorrent-0.1.typelib: ETorrent-0.1.gir
	@INTROSPECTION_COMPILER@ -o $@ $^
endif
	
EXTRA_DIST = $(libetorrent_la_VALASOURCES) ETorrent-0.1.gir etorrent-0.1.vapi libetorrent.vala.stamp

CLEANFILES = *.h *.c *.o ETorrent-0.1.* *.vapi *.stamp

DISTCLEANFILES = $(CLEANFILES) Makefile.in
