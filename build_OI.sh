#! /usr/bin/env bash
set -eux

source ./machine-setup.sh > /dev/null 2>&1
cwd=`pwd`

USE_PREINST_LIBS=${USE_PREINST_LIBS:-"true"}
if [ $USE_PREINST_LIBS = true ]; then
  export MOD_PATH
  source ./modulefiles/snowDA.$target             > /dev/null 2>&1
else
  export MOD_PATH=${cwd}/lib/modulefiles
  #if [ $target = wcoss_cray ]; then
  #  source ../modulefiles/fv3gfs/global_cycle.${target}_userlib > /dev/null 2>&1
  #else
    source ./snowDA.$target           > /dev/null 2>&1
  #fi
fi
module list

# Check final exec folder exists
if [ ! -d "./exec" ]; then
  mkdir ./exec
fi

cd ${cwd}/sorc/
./makefile.sh
