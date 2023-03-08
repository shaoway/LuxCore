# SPDX-License-Identifier: GPL-2.0-or-later

###############################################################################
#
# This is a build framework used by platform maintainers. This framework is
# designed to build libraries on Windows, macOS and Linux.
#
#
#
#
#
#
#
###############################################################################

if ("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
  message(FATAL_ERROR "In-source builds are not allowed")
endif()

project("LuxDeps")
cmake_minimum_required(VERSION 3.20)
if(POLICY CMP0135)
  cmake_policy(SET CMP0135 NEW) # CMake 3.24+ Set the date/time for extracted files to time of extraction
endif()
include(ExternalProject)

include(cmake/check.cmake)
include(cmake/options.cmake)
include(cmake/versions.cmake)
include(cmake/download.cmake)

include(cmake/zlib.cmake)
include(cmake/spdlog.cmake)
include(cmake/expat.cmake)
include(cmake/yamlcpp.cmake)
include(cmake/json.cmake)
include(cmake/blosc.cmake)
include(cmake/png.cmake)
include(cmake/boost.cmake)
include(cmake/tbb.cmake)
include(cmake/embree.cmake)
include(cmake/imath.cmake)
include(cmake/openexr.cmake)
include(cmake/bzip2.cmake)
include(cmake/minizipng.cmake)
include(cmake/pybind11.cmake)
include(cmake/opencolorio.cmake)
include(cmake/opensubdiv.cmake)
include(cmake/robinmap.cmake)
include(cmake/jpeg.cmake)
include(cmake/openjpeg.cmake)
include(cmake/tiff.cmake)
include(cmake/pugixml.cmake)
include(cmake/webp.cmake)
include(cmake/openimageio.cmake)
include(cmake/oidn.cmake)
include(cmake/openvdb.cmake)
