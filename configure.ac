AC_PREREQ([2.65])
AC_INIT([etorrent], [0.1], [inizan.yannick@gmail.com], [etorrent])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([subdir-objects])
AC_CONFIG_FILES([Makefile
		libetorrent/Makefile
		src/Makefile
		etorrent-0.1.pc])

AM_PROG_AR
LT_INIT
AC_PROG_CC
AM_PROG_VALAC

pkg_modules="glib-2.0 >= 2.38
             gobject-2.0 >= 2.38
             gio-2.0 >= 2.38
             libsoup-2.4
             json-glib-1.0"
PKG_CHECK_MODULES(LIBETORRENT, [$pkg_modules])
AC_SUBST(LIBETORRENT_CFLAGS)
AC_SUBST(LIBETORRENT_LIBS)

main_modules="gtk+-3.0"

PKG_CHECK_MODULES(ETORRENT, [$main_modules])
AC_SUBST(ETORRENT_CFLAGS)
AC_SUBST(ETORRENT_LIBS)

GOBJECT_INTROSPECTION_CHECK([0.9.0])

AC_OUTPUT
