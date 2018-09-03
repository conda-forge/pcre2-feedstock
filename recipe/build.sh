#!/usr/bin/env bash

# Not only does this hopefully make pcre2 faster,
# it fixes a test failure on macOS. See link below.
#
# ref: https://bugs.exim.org/show_bug.cgi?id=1642
#
CFLAGS="${CFLAGS} -O3"
CXXFLAGS="${CXXFLAGS} -O3"

./configure \
    --prefix="${PREFIX}" \
    --enable-jit \

make -j${CPU_COUNT} ${VERBOSE_AT}
make check
make install

# We can remove this when we start using the new conda-build.
find $PREFIX -name '*.la' -delete
