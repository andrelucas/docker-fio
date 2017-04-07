#!/bin/sh

set -e -u

VER=${1:-}
srcdir="/source/linux-${VER}"

echo "*** Begin $(date)"

if [ -d "$srcdir" ]; then
    echo "** ${srcdir} exists, may skew speed tests"
    rm -rf "${srcdir}"
fi

echo "++ Unpack"
tar xJf "/tmp/linux-${VER}.tar.xz"

cd "${srcdir}"

echo "++ Configure"
make defconfig

echo "++ Build"
make -j"$(nproc)"

echo "++ modules_install"
make modules_install

echo "*** End $(date)"
