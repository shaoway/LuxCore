################################################################################
# Copyright 1998-2020 by authors (see AUTHORS.txt)
#
#   This file is part of LuxCoreRender.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################


# Don't allow in-source builds.
if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
    message(FATAL_ERROR
      "LuxCoreRender is not allowed build within the source directory!\n"
    )
endif()


################################################################################
#
# Check and configure cmake
#
################################################################################

cmake_minimum_required(VERSION 3.20)

# So library linking is more sane
cmake_policy(SET CMP0003 NEW)

# So BUILDINFO strings are automatically quoted
cmake_policy(SET CMP0005 NEW)

# So syntax problems are errors
cmake_policy(SET CMP0010 NEW)

# Input directories must have CMakeLists.txt
cmake_policy(SET CMP0014 NEW)

if(POLICY CMP0072)
  cmake_policy(SET CMP0072 NEW) # for OpenGL GLVND
endif()

# find_package() uses <PackageName>_ROOT variables.
if(POLICY CMP0074)
  cmake_policy(SET CMP0074 NEW)
endif()

# Install CODE|SCRIPT allow the use of generator expressions.
if(POLICY CMP0087)
  cmake_policy(SET CMP0087 NEW)
endif()

# This boots up the generator:
enable_language(C)
enable_language(CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# The following implicitly boots up the generator, so don't move it up:

project(LuxRays)

if (NOT DEFINED LuxRays_SOURCE_DIR)
	SET(LuxRays_SOURCE_DIR "${CMAKE_SOURCE_DIR}")
endif (NOT DEFINED LuxRays_SOURCE_DIR)

################################################################################
#
# Include necessary submodules
#
################################################################################

set(CMAKE_MODULE_PATH
	"${LuxRays_SOURCE_DIR}"
	"${LuxRays_SOURCE_DIR}/cmake"
	"${LuxRays_SOURCE_DIR}/cmake/Utils"
	"${LuxRays_SOURCE_DIR}/cmake/Packages"
	"${LuxRays_SOURCE_DIR}/cmake/SpecializedConfig"
      )

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

include(PlatformSpecific)
include(Configuration)
include(KernelPreprocess)

# Install CMake modules
#add_subdirectory(CMake)

set(LuxRays_INCLUDE_DIR "${LuxRays_SOURCE_DIR}/include")
include_directories("${LuxRays_INCLUDE_DIR}")

include_directories("${LuxRays_SOURCE_DIR}/deps/cuew/include")
include_directories("${LuxRays_SOURCE_DIR}/deps/clew/include")
include_directories("${LuxRays_SOURCE_DIR}/deps/optix-7.1.0/include")
include_directories("${LuxRays_SOURCE_DIR}/deps/robin-hood-hashing-3.9.1/src/include")

# Find dependencies
include(Dependencies)

################################################################################
#
# Build options
#
################################################################################

if (LUXRAYS_DISABLE_OPENCL)
	ADD_DEFINITIONS("-DLUXRAYS_DISABLE_OPENCL")
	# CUDA requires OpenCL support
	ADD_DEFINITIONS("-DLUXRAYS_DISABLE_CUDA")

	message(STATUS "OpenCL and CUDA support: disabled")
else()
	if (LUXRAYS_DISABLE_CUDA)
		ADD_DEFINITIONS("-DLUXRAYS_DISABLE_CUDA")
		message(STATUS "OpenCL support: enabled")
		message(STATUS "CUDA support: disabled")
	else()
		message(STATUS "OpenCL support: enabled")
		message(STATUS "CUDA support: enabled")
	endif()
endif()

if (LUXCORE_DISABLE_OIDN)
	ADD_DEFINITIONS("-DLUXCORE_DISABLE_OIDN")

	message(STATUS "Intel OIDN support: disabled")
else()
	message(STATUS "Intel OIDN support: enabled")
endif()

if (BUILD_LUXCORE_DLL)
	set(LUXCORE_LIBRARY luxcore)
	ADD_DEFINITIONS("-DLUXCORE_DLL")
else()
  set(LUXCORE_LIBRARY luxcore slg-core slg-film slg-kernels luxrays bcd
    ${OPENSUBDIV_OSDCPU_LIBRARY} ${OPENVDB_LIBRARIES} ${OPENCOLORIO_OPENCOLORIO_LIBRARY}
    ${OPENIMAGEIO_LIBRARIES} ${OPENIMAGEIO_UTIL_LIBRARIES}
    ${BLOSC_LIBRARIES} ${EMBREE_LIBRARIES}
    ${OIDN_LIBRARIES} ${SPDLOG_LIBRARIES} ${FMT_LIBRARIES}
    ${TBB_LIBRARIES} ${TIFF_LIBRARIES} ${OPENEXR_LIBRARIES} ${PNG_LIBRARIES} ${JPEG_LIBRARIES}
  )
endif()

################################################################################
#
# LuxRays, SLG, LuxCore and PyLuxCoreTools libraries
#
################################################################################

set(GENERATED_DIR "${CMAKE_BINARY_DIR}/generated")
set(GENERATED_INCLUDE_DIR "${GENERATED_DIR}/include")

file(MAKE_DIRECTORY ${GENERATED_INCLUDE_DIR})
include_directories(${GENERATED_INCLUDE_DIR})

add_subdirectory(src/luxrays)
add_subdirectory(src/slg)
add_subdirectory(src/luxcore)
add_subdirectory(src/pyluxcoretools)

################################################################################
#
# Samples
#
################################################################################

if((${CMAKE_SYSTEM_NAME} MATCHES "Linux") OR OSX_BUILD_DEMOS OR WIN_BUILD_DEMOS)
	add_subdirectory(samples/luxcoredemo)
	add_subdirectory(samples/luxcorescenedemo)

	if (NOT WIN32 OR NOT BUILD_LUXCORE_DLL)
		# Internal tests can not be compiled on WIN32 with DLL enabled
		add_subdirectory(tests/luxcoreimplserializationdemo)
	endif()
endif()

if (NOT WIN32 OR WIN_BUILD_DEMOS)
	add_subdirectory(samples/luxcoreconsole)
endif()

if(OPENGL_FOUND)
	add_subdirectory(samples/luxcoreui)
endif(OPENGL_FOUND)


################################################################################
#
# Tests
#
################################################################################

add_subdirectory(pyunittests)

################################################################################
#
# For non win32 we'll have to copy everything to a single dir
#
################################################################################

include(AssembleBinDirs)
