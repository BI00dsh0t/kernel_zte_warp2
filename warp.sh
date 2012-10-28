#!/bin/bash
make distclean
# [[ `diff arch/arm/configs/tuna_defconfig .config ` ]] && \
#	{ echo "Unmatched defconfig!"; exit -1; }
pwd=`readlink -f .` 
export CROSS_COMPILE=$pwd/kernel-extras/arm-eabi-4.4.3/bin/arm-eabi-
export ARCH=arm

# sed -i s/CONFIG_LOCALVERSION=\".*\"/CONFIG_LOCALVERSION=\"-leanKernel-${1}\"/ .config
make agat_zte_defconfig
# make headers_install
make modules
make -j8 zImage 2>&1 | tee ~/logs/warp-sequent.txt

[ -d modules ] || mkdir -p modules
find -name '*.ko' -exec cp -av {} modules/ \;

