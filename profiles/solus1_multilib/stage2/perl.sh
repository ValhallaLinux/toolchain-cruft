#!/bin/bash
# 
# Copyright (c) 2015 Ikey Doherty
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Always set PKG_NAME
PKG_NAME="xz"
PKG_URL="http://www.cpan.org/src/5.0/perl-5.20.1.tar.gz"
PKG_HASH="fef10210f9e6f4dc2d190be0aee8e1fa2af664630f1d415868d33eebca26d4b5"

source "${FUNCTIONSFILE}"

pkg_setup()
{
    set -e
    pkg_extract

    pushd $(pkg_source_dir) >/dev/null

    export CC="${XTOOLCHAIN}-gcc"
    export AR="${XTOOLCHAIN}-ar"
    export RANLIB="${XTOOLCHAIN}-ranlib"
    # Always force compiler, otherwise it'll link against host libpthread, librt, etc
    sh ./Configure -des -Dprefix=/tools -Dlibs=-lm -Dcc="${XTOOLCHAIN}-gcc"
}

pkg_build()
{
    set -e
    export LC_ALL="C"
    export LANG="C"
    pushd $(pkg_source_dir) >/dev/null
    pkg_make
}

pkg_install()
{
    set -e
    export LC_ALL="C"
    export LANG="C"
    pushd $(pkg_source_dir) >/dev/null
    pkg_make install
}

# Now handle the arguments
handle_args $*
