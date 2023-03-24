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

include(FindPkgMacros)
getenv_path(LuxRays_DEPENDENCIES_DIR)

################################################################################
#
# Core dependencies
#
################################################################################

find_package(Python COMPONENTS Development REQUIRED)
find_package(Threads REQUIRED)
find_package(Fmt REQUIRED)
find_package(Spdlog REQUIRED)
find_package(Bzip2 REQUIRED)
find_package(PugiXml REQUIRED)
find_package(MiniZipNG REQUIRED)
find_package(OpenJPEG REQUIRED)
find_package(Webp REQUIRED)
find_package(TIFF REQUIRED)
find_package(Json REQUIRED)
find_package(PNG REQUIRED)
find_package(JPEG REQUIRED)
find_package(Blosc REQUIRED)
find_package(Imath REQUIRED)
find_package(PythonLibs)
find_package(glfw3 REQUIRED)
find_package(OpenImageIO REQUIRED)
find_package(OpenEXR REQUIRED)
find_package(OpenGL)
find_package(TBB REQUIRED)
find_package(Embree REQUIRED)
find_package(OpenColorIO REQUIRED)
find_package(OpenVDB REQUIRED)
find_package(OpenSubdiv REQUIRED)
find_package(OpenImageDenoise REQUIRED)

add_bundled_libraries(openimageio/lib)
add_bundled_libraries(boost/lib)
add_bundled_libraries(tbb/lib)
add_bundled_libraries(embree/lib)
add_bundled_libraries(opencolorio/lib)
add_bundled_libraries(openvdb/lib)
add_bundled_libraries(opensubdiv/lib)
add_bundled_libraries(openimagedenoise/lib)

find_program(PYSIDE_UIC NAMES pyside-uic pyside2-uic pyside6-uic
		HINTS "${PYTHON_INCLUDE_DIRS}/../Scripts"
		PATHS "c:/Program Files/Python${PYTHON_V}/Scripts")

# include_directories(${PYTHON_INCLUDE_DIRS})

# Find Boost
if(BUILD_STATIC)
  set(Boost_USE_STATIC_LIBS       ON)
else()
  set(Boost_USE_STATIC_LIBS       OFF)
endif()
set(Boost_USE_MULTITHREADED     ON)
set(Boost_USE_STATIC_RUNTIME    OFF)
set(Boost_MINIMUM_VERSION       "1.56.0")

# For Windows builds, PYTHON_V must be defined as "3x" (x=Python minor version, e.g. "35")
# For other platforms, specifying python minor version is not needed
set(LUXRAYS_BOOST_COMPONENTS thread program_options filesystem serialization iostreams regex system chrono serialization python numpy)
find_package(Boost ${Boost_MINIMUM_VERSION} COMPONENTS ${LUXRAYS_BOOST_COMPONENTS} REQUIRED)

# OpenMP
if(NOT APPLE)
	find_package(OpenMP)
	if (OPENMP_FOUND)
		MESSAGE(STATUS "OpenMP found - compiling with")
   		set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
   		set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
	else()
		MESSAGE(WARNING "OpenMP not found - compiling without")
	endif()
endif()

# Find GTK 3.0 for Linux only (required by luxcoreui NFD)
# if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
# 	find_package(PkgConfig REQUIRED)
# 	pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
# 	include_directories(${GTK3_INCLUDE_DIRS})
# endif()

# Find BISON
IF (NOT BISON_NOT_AVAILABLE)
	find_package(BISON)
ENDIF (NOT BISON_NOT_AVAILABLE)

# Find FLEX
IF (NOT FLEX_NOT_AVAILABLE)
	find_package(FLEX)
ENDIF (NOT FLEX_NOT_AVAILABLE)

