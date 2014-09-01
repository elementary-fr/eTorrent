AM_CPPFLAGS = $(ETORRENT_CFLAGS)

AM_CFLAGS = -I../libetorrent `pkg-config --cflags glib-2.0 gobject-2.0` \
	-w

bin_PROGRAMS = etorrent
	
etorrent_SOURCES = main.vala
etorrent_LDADD = ../libetorrent/libetorrent.la $(ETORRENT_LIBS)
etorrent_VALAFLAGS = ../libetorrent/etorrent-0.1.vapi

CLEANFILES = *.c *.o *.stamp etorrent

DISTCLEANFILES = $(CLEANFILES) Makefile.in
