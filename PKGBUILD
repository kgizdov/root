# Maintainer: Frank Siegert <frank.siegert@googlemail.com>
# Contributor: Scott Lawrence <bytbox@gmail.com>
# Contributor: Thomas Dziedzic < gostrc at gmail >
# Contributor: Sebastian Voecking <voeck@web.de>

pkgname=root
pkgver=6.06.04
pkgrel=2
pkgdesc='C++ data analysis framework and interpreter from CERN.'
arch=('i686' 'x86_64')
url='http://root.cern.ch'
license=('LGPL2.1')
makedepends=('cmake')
depends=('desktop-file-utils'
'fftw'
'ftgl'
'giflib'
'glew'
'graphviz'  # for /usr/include/graphviz/gvc.h and for /usr/lib/libgvc.so -- for gviz=ON
'gsl'
'intel-tbb'  # unlisted optional dependency -- for builtin_tbb=OFF and tbb=ON
'libmysqlclient'
'libldap'  # for /usr/include/ldap.h and for /usr/lib/libldap.so -- for ldap=ON
'mesa'  # for /usr/include/GL/gl.h and for /usr/lib/libGL.so -- for opengl=ON (OpenGL support, requires libGL and libGLU)
'mesa-libgl'  # unlisted optional dependency -- for opengl=ON (OpenGL support, requires libGL and libGLU)
'postgresql-libs'
'python'
'unixodbc'
'shared-mime-info'
'xmlrpc-c'
# 'xorg-fonts-75dpi'  # not needed for now
# 'gcc-fortran'  # not needed for now
'libiodbc'
'gtk-update-icon-cache'
'libafterimage')
install='root.install'
options=('!emptydirs')
source=("https://root.cern.ch/download/root_v${pkgver}.source.tar.gz"
'root.sh'
'rootd'
'root.xml'
'python3.diff'
'call_PyErr_Clear_if_no_such_attribute.patch'
'settings.cmake')
md5sums=('55a2f98dd4cea79c9c4e32407c2d6d17'
         '0e883ad44f99da9bc7c23bc102800b62'
         'efd06bfa230cc2194b38e0c8939e72af'
         'e2cf69b204192b5889ceb5b4dedc66f7'
         '1777520d65cc545b5416ee2fed0cd45c'
         'f36f7bff97ed7232d8534c2ef166b2bf'
         '23b58c1a04895db427e2b4dbd6ee037e')

prepare(){
	## https://sft.its.cern.ch/jira/browse/ROOT-6924
	cd ${pkgname}-${pkgver}

	patch -p1 < ${srcdir}/python3.diff
	2to3 -w etc/dictpch/makepch.py 2>&1 > /dev/null

        ## https://sft.its.cern.ch/jira/browse/ROOT-7640
        patch -p1 < ${srcdir}/call_PyErr_Clear_if_no_such_attribute.patch
}

build() {
	[ -d ${srcdir}/build ] || mkdir ${srcdir}/build
	cd ${srcdir}/build

    cmake -C ${srcdir}/settings.cmake ${srcdir}/${pkgname}-${pkgver}

    make ${MAKEFLAGS}
}

package() {
	cd ${srcdir}/build

	make DESTDIR=${pkgdir} install

	install -D ${srcdir}/root.sh \
		${pkgdir}/etc/profile.d/root.sh
	install -D ${srcdir}/rootd \
		${pkgdir}/etc/rc.d/rootd
	install -D -m644 ${srcdir}/root.xml \
		${pkgdir}/usr/share/mime/packages/root.xml

	install -D -m644 ${srcdir}/${pkgname}-${pkgver}/build/package/debian/root-system-bin.desktop.in \
		${pkgdir}/usr/share/applications/root-system-bin.desktop
	# replace @prefix@ with /usr for the desktop
	sed -e 's_@prefix@_/usr_' -i ${pkgdir}/usr/share/applications/root-system-bin.desktop

	install -D -m644 ${srcdir}/${pkgname}-${pkgver}/build/package/debian/root-system-bin.png \
		${pkgdir}/usr/share/icons/hicolor/48x48/apps/root-system-bin.png

	# use a file that pacman can track instead of adding directly to ld.so.conf
	install -d ${pkgdir}/etc/ld.so.conf.d
	echo '/usr/lib/root' > ${pkgdir}/etc/ld.so.conf.d/root.conf

	rm -rf ${pkgdir}/etc/root/daemons
}

