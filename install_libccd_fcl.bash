#!/bin/bash
set -e  # exit on first error
DIR=/tmp

install_libccd_fcl()
{
  if (ldconfig -p | grep libccde); then
    echo "libccd has been installed."
  else
    echo "Install libccd......"
    cd $DIR
    rm -rf libccd
    git clone --branch v2.0 https://github.com/danfis/libccd.git
    cd libccd
    mkdir -p build && cd build
    cmake -G "Unix Makefiles" -DBUILD_SHARED_LIBS=ON -DENABLE_DOUBLE_PRECISION=ON .. > /dev/null
    make && sudo make install > /dev/null
    echo "libccd is installed succesfully."
  fi
  if (ldconfig -p | grep libfcli); then
    echo "fcl has been installed."
  else
    echo "Install fcl......."
    cd $DIR
    rm -rf fcl
    git clone --branch 0.5.0 https://github.com/flexible-collision-library/fcl.git
    cd fcl
    mkdir -p build && cd build
    cmake ..
    make -j8 > /dev/null
    sudo -E make install > /dev/null
    echo "fcl is installed successfully."
  fi
}


install_libccd_fcl