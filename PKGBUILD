# Maintainer: Frank Siegert <frank.siegert@googlemail.com>
# Contributor: Scott Lawrence <bytbox@gmail.com>
# Contributor: Thomas Dziedzic < gostrc at gmail >
# Contributor: Sebastian Voecking <voeck@web.de>
# Contributor: Konstantin Gizdov <kgizdov@gmail.com>

pkgname=root
pkgver=6.06.06
pkgrel=1
pkgdesc='C++ data analysis framework and interpreter from CERN.'
arch=('i686' 'x86_64')
url='http://root.cern.ch'
license=('LGPL2.1')
makedepends=('cmake')
depends=('cfitsio'  # for /usr/include/fitsio2.h and for /usr/lib/libcfitsio.so -- for fitsio=ON
'desktop-file-utils'
'fftw'
'ftgl'
# 'gcc-fortran'  # not needed for now
'giflib'
'glew'
'graphviz'  # for /usr/include/graphviz/gvc.h and for /usr/lib/libgvc.so -- for gviz=ON
'gsl'
'gtk-update-icon-cache'
'intel-tbb'  # unlisted optional dependency -- for builtin_tbb=OFF and tbb=ON
'libafterimage'  # for asimage=ON
'libmysqlclient'
'libldap'  # for /usr/include/ldap.h and for /usr/lib/libldap.so -- for ldap=ON
'libiodbc'
'llvm-libs'  # for builtin_llvm=OFF
'libgl'  # for /usr/include/GL/gl.h and for /usr/lib/libGL.so -- for opengl=ON (OpenGL support, requires libGL and libGLU)
'postgresql-libs'
'python'
'pythia'  # for pythia8=ON
'unixodbc'
'shared-mime-info'
'xmlrpc-c'
# 'xorg-fonts-75dpi'  # not needed for now
)
install='root.install'
options=('!emptydirs')
source=("https://root.cern.ch/download/root_v${pkgver}.source.tar.gz"
'root.sh'
'rootd'
'root.xml'
'python3.diff'
'call_PyErr_Clear_if_no_such_attribute.patch'
'settings.cmake')
md5sums=('4308449892210c8d36e36924261fea26'
         '0e883ad44f99da9bc7c23bc102800b62'
         'efd06bfa230cc2194b38e0c8939e72af'
         'e2cf69b204192b5889ceb5b4dedc66f7'
         '6e5b69f1396f84727477cb1bbcc71410'
         'f36f7bff97ed7232d8534c2ef166b2bf'
         'e91d34e76bbe9f5015fa0b9634efdf74')
sha256sums=('0a7d702a130a260c72cb6ea754359eaee49a8c4531b31f23de0bfcafe3ce466b'
            '71ed39f7e5a605a6a02e3d0ba79c997b8e7f02551898c27112eb78f07d9d8244'
            '6a4ef7b32710d414ee47d16310b77b95e4cf1d3550209cf8a41d38a945d05e5f'
            'b103d46705883590d9e07aafb890ec1150f63dc2ca5f40d67e6ebef49a6d0a32'
            'ddf9bd918ba389564841515ca22216d65d6e32f2aa46fbc3782b87f06ff48766'
            '437ed0fb2c46d5ca8e37cc689f87dfe12429f6a243d4e5cf2d395a177de7e90f'
            '9d4a69d6fe31b36c3c9a9ed8d4655e13d416b31ca9b615c89456e1e17a522658')
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
