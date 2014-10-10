# Configuration for Linux on ARM.
# Generating binaries for the ARMv7-a architecture and higher with NEON
#
ARCH_ARM_HAVE_ARMV7A            := true
ARCH_ARM_HAVE_VFP               := true
ARCH_ARM_HAVE_VFP_D32           := true
ARCH_ARM_HAVE_NEON              := true

ifeq ($(TARGET_CPU_VARIANT),$(filter $(TARGET_CPU_VARIANT),cortex-a15 krait))
	arch_variant_cflags := -mcpu=cortex-a15 -mfpu=neon-vfpv4
else
ifeq ($(strip $(TARGET_CPU_VARIANT)),cortex-a9)
	arch_variant_cflags := -mcpu=cortex-a9 -mfpu=neon
else
ifeq ($(strip $(TARGET_CPU_VARIANT)),cortex-a8)
	arch_variant_cflags := -mcpu=cortex-a8 -mfpu=neon
	arch_variant_ldflags := -Wl,--fix-cortex-a8
else
ifeq ($(strip $(TARGET_CPU_VARIANT)),cortex-a7)
	arch_variant_cflags := -mcpu=cortex-a7 -mfpu=neon-vfpv4
else
ifeq ($(strip $(TARGET_CPU_VARIANT)),cortex-a5)
	arch_variant_cflags := -mcpu=cortex-a5 -mfpu=neon-vfpv4
else
ifeq ($(strip $(TARGET_CPU_VARIANT)),scorpion)
	arch_variant_cflags := -mcpu=cortex-a8 -mfpu=neon
else
	arch_variant_cflags := -march=armv7-a -mfpu=neon
endif
endif
endif
endif
endif
endif

arch_variant_cflags += \
    -mfloat-abi=softfp \
    -mfpu=neon \
    -DHARDFLOAT \
    -DSK_HARDWARE_FLOAT \
    -DNDEBUG \
    -mcpu=cortex-a15 \
    -mtune=cortex-a15 \
    -fira-loop-pressure \
    -mvectorize-with-neon-quad \
    -fforce-addr \
    -funsafe-loop-optimizations \
    -funroll-loops \
    -ftree-loop-distribution \
    -fsection-anchors \
    -fivopts \
    -ftree-loop-im \
    -ftree-loop-ivcanon \
    -ffunction-sections \
    -fgcse-las \
    -fgcse-sm \
    -fweb \
    -ffp-contract=fast \
    -Wno-unused-parameter \
    -Wno-unused-value \
    -Wno-unused-function \
    -pipe
