define HELP_TEXT

LuxCoreRender Convenience Targets
   Provided for building (multiple targets can be used at once).

   * debug:         Build a debug binary.
   * ccache:        Use ccache for faster rebuilds.

Other Convenience Targets
   Provided for other building operations.

   * deps:          Build library dependencies (intended only for platform maintainers).

Environment Variables

   * BUILD_CMAKE_ARGS:      Arguments passed to CMake.
   * BUILD_DIR:             Override default build path.
   * NPROCS:                Number of processes to use building (auto-detect when omitted).

Information

   * help:              This help message.

endef
# HELP_TEXT (end)

# System Vars
OS:=$(shell uname -s)
OS_NCASE:=$(shell uname -s | tr '[A-Z]' '[a-z]')
CPU:=$(shell uname -m)

# This makefile is not meant for Windows
ifeq ($(OS),Windows_NT)
	$(error On Windows, use "cmd //c make.bat" instead of "make")
endif

ifndef NPROCS
	NPROCS:=1
	ifeq ($(OS), Linux)
		NPROCS:=$(shell nproc)
	endif
	ifeq ($(OS), NetBSD)
		NPROCS:=$(shell getconf NPROCESSORS_ONLN)
	endif
	ifneq (,$(filter $(OS),Darwin FreeBSD))
		NPROCS:=$(shell sysctl -n hw.ncpu)
	endif
endif


LUX_DIR:=$(shell pwd -P)
BUILD_TYPE?=Release

CMAKE_CONFIG_ARGS := $(BUILD_CMAKE_ARGS)

ifndef BUILD_DIR
	BUILD_DIR:=$(shell dirname "$(LUX_DIR)")/build_$(OS_NCASE)
endif

DEPS_SOURCE_DIR:=$(LUX_DIR)/extlibs

ifndef DEPS_BUILD_DIR
	DEPS_BUILD_DIR:=$(BUILD_DIR)/deps
endif

ifndef DEPS_INSTALL_DIR
	DEPS_INSTALL_DIR:=$(shell dirname "$(LUX_DIR)")/lib/$(OS_NCASE)_$(CPU)
endif

LIBDIR:=$(DEPS_INSTALL_DIR)

all: .FORCE
	@echo
	@echo Configuring LuxCoreRender in \"$(BUILD_DIR)\" ...
	cmake $(CMAKE_CONFIG_ARGS) -G"Unix Makefiles" -S"$(LUX_DIR)" -B"$(BUILD_DIR)"  \
	-DCMAKE_BUILD_TYPE:STRING=$(BUILD_TYPE) -DLIBDIR=$(LIBDIR)                     \
	-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON                                        \
	-DBoost_ROOT=$(LIBDIR)/boost                                                   \
	-DFMT_ROOT=${LIBDIR}/fmt                                                       \
	-DSPDLOG_ROOT=${LIBDIR}/spdlog                                                 \
	-DBZIP2_ROOT=${LIBDIR}/bzip2                                                   \
	-DWEBP_ROOT=${LIBDIR}/webp                                                     \
	-DMINIZIPNG_ROOT=${LIBDIR}/minizipng                                           \
	-DOPENJPEG_ROOT=${LIBDIR}/openjpeg                                             \
	-DTIFF_ROOT=$(LIBDIR)/tiff                                                     \
	-DZLIB_ROOT=$(LIBDIR)/zlib                                                     \
	-DJPEG_ROOT=$(LIBDIR)/jpeg                                                     \
	-DPUGIXML_ROOT=${LIBDIR}/pugixml                                               \
	-DJSON_ROOT=$(LIBDIR)/json                                                     \
	-DTBB_ROOT=$(LIBDIR)/tbb                                                       \
	-DPNG_ROOT=$(LIBDIR)/png                                                       \
	-DIMATH_ROOT=$(LIBDIR)/imath                                                   \
	-DOPENIMAGEIO_ROOT=$(LIBDIR)/openimageio                                       \
	-DBLOSC_ROOT=$(LIBDIR)/blosc                                                   \
	-DEMBREE_ROOT=$(LIBDIR)/embree                                                 \
	-DOPENIMAGEDENOISE_ROOT=$(LIBDIR)/openimagedenoise                             \
	-DOPENCOLORIO_ROOT=$(LIBDIR)/opencolorio                                       \
	-DOPENEXR_ROOT=$(LIBDIR)/openexr                                               \
	-DOPENSUBDIV_ROOT=$(LIBDIR)/opensubdiv                                         \
	-DOPENVDB_ROOT=$(LIBDIR)/openvdb                                               \
	-DBUILD_LUXCORE_DLL=OFF
	@echo
	@echo Build LuxCoreRender ...
	make -C "$(BUILD_DIR)" -j $(NPROCS) VERBOSE=$(V)

deps: .FORCE
	@echo
	@echo Configuring dependencies in \"$(DEPS_BUILD_DIR)\", install to \"$(DEPS_INSTALL_DIR)\"

	@cmake -S"$(DEPS_SOURCE_DIR)" \
	       -B"$(DEPS_BUILD_DIR)"  \
               -G"Unix Makefiles"     \
	       -DLIBDIR=$(LIBDIR)

	@echo
	@echo Building dependencies ...
	make -C "$(DEPS_BUILD_DIR)" -j $(NPROCS)
	@echo
	@echo Dependencies successfully built and installed to $(DEPS_INSTALL_DIR).
	@echo



export HELP_TEXT
help: .FORCE
	@echo "$$HELP_TEXT"

.PHONY: help

.FORCE:

