AM_CPPFLAGS = $(ETORRENT_CFLAGS)

AM_CFLAGS = -I../libetorrent `pkg-config --cflags gtk+-3.0` \
	-w

bin_PROGRAMS = etorrent

etorrent_SOURCES = main.vala window.vala widgets/headerbar.vala widgets/closemenu.vala
etorrent_LDADD = ../libetorrent/libetorrent.la $(ETORRENT_LIBS)
etorrent_VALAFLAGS = ../libetorrent/etorrent-0.1.vapi --pkg gtk+-3.0

CLEANFILES = widgets/*.c widgets/*.o *.c *.o *.stamp etorrent

DISTCLEANFILES = $(CLEANFILES) Makefile.in
