# Maintainer: Konstantin Gizdov <kgizdov@gmail.com>
# Contributor: Frank Siegert <frank.siegert@googlemail.com>
# Contributor: Scott Lawrence <bytbox@gmail.com>
# Contributor: Thomas Dziedzic < gostrc at gmail >
# Contributor: Sebastian Voecking <voeck@web.de>

pkgname=root
pkgver=6.06.08
pkgrel=2
pkgdesc='C++ data analysis framework and interpreter from CERN.'
arch=('i686' 'x86_64')
url='http://root.cern.ch'
license=('LGPL2.1')
makedepends=('cmake')
depends=('cfitsio'  # for /usr/include/fitsio2.h and for /usr/lib/libcfitsio.so -- for fitsio=ON
'fftw'
'ftgl'  # also includes libgl, mesa, libldap
# 'gcc-fortran'  # not needed
# 'giflib'  # already included
'glew'
'graphviz'  # also includes giflib, for /usr/include/graphviz/gvc.h and for /usr/lib/libgvc.so -- for gviz=ON
'gsl'
'hicolor-icon-theme'
'intel-tbb'  # unlisted optional dependency -- for builtin_tbb=OFF and tbb=ON
'libafterimage'  # for asimage=ON
# 'libgl'  # already included for /usr/include/GL/gl.h and for /usr/lib/libGL.so -- for opengl=ON
'libiodbc'
# 'libldap'  # already included, for /usr/include/ldap.h and for /usr/lib/libldap.so -- for ldap=ON
'libmysqlclient'
# 'llvm'  # for builtin_llvm=OFF, but currently not possible
'postgresql-libs'
'pythia'  # for pythia8=ON
'python'
'sqlite'
'tex-gyre-fonts'  # nicer substitution as per Arch Wiki
'unixodbc'
'xmlrpc-c'
)
optdepends=('gcc-fortran: Enable the Fortran components of ROOT'
            'tcsh: Legacy CSH support'
)
options=('!emptydirs')
source=("https://root.cern.ch/download/root_v${pkgver}.source.tar.gz"
'call_PyErr_Clear_if_no_such_attribute.patch'
'disable-gcc-abi-check.diff'
'python3.diff'
'root.sh'
'root.xml'
'rootd'
'settings.cmake')
sha256sums=('7cb836282014cce822ef589cad27811eb7a86d7fad45a871fa6b0e6319ec201a'
            '437ed0fb2c46d5ca8e37cc689f87dfe12429f6a243d4e5cf2d395a177de7e90f'
            'e03fff4accf7cee4e7329b305f1e0df7bf804dbced08d52566af789bc77ea0b0'
            'd566bc44f0df1915ac81c41b8ef7eff0d9fec8728533b00b9e654a2a4eff9af1'
            '9d1f8e7ad923cb5450386edbbce085d258653c0160419cdd6ff154542cc32bd7'
            'b103d46705883590d9e07aafb890ec1150f63dc2ca5f40d67e6ebef49a6d0a32'
            '3c45b03761d5254142710b7004af0077f18efece7c95511910140d0542c8de8a'
            '55be51afce766acca6ddd8123518af47a5d43c826233a2267c2404b68b662aee')
prepare(){
    ## https://sft.its.cern.ch/jira/browse/ROOT-6924
    cd ${pkgname}-${pkgver}

    patch -p1 < ${srcdir}/python3.diff
    2to3 -w etc/dictpch/makepch.py 2>&1 > /dev/null

    ## https://sft.its.cern.ch/jira/browse/ROOT-7640
    patch -p1 < ${srcdir}/call_PyErr_Clear_if_no_such_attribute.patch

    ## disable check newly introduced in 6.06.06
    patch -p1 < ${srcdir}/disable-gcc-abi-check.diff
}

build() {
    [ -d ${srcdir}/build ] || mkdir ${srcdir}/build
    cd ${srcdir}/build

    CFLAGS="${CFLAGS} -pthread" \
    CXXFLAGS="${CXXFLAGS} -pthread -D_GLIBCXX_USE_CXX11_ABI=0" \
    LDFLAGS="${LDFLAGS} -pthread -Wl,--no-undefined" \
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
