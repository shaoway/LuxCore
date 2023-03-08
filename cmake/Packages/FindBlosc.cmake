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

# If BLOSC_ROOT was defined in the environment, use it.
IF(NOT BLOSC_ROOT AND NOT $ENV{BLOSC_ROOT} STREQUAL "")
  SET(BLOSC_ROOT $ENV{BLOSC_ROOT})
ENDIF()

SET(_blosc_SEARCH_DIRS
  ${BLOSC_ROOT}
  /opt/lib/blosc
)

FIND_PATH(BLOSC_INCLUDE_DIR
  NAMES
  blosc.h
  HINTS
  ${_blosc_SEARCH_DIRS}
  PATH_SUFFIXES
  include
)

FIND_LIBRARY(BLOSC_LIBRARY
  NAMES
  blosc
  HINTS
  ${_blosc_SEARCH_DIRS}
  PATH_SUFFIXES
  lib64 lib
)

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Blosc DEFAULT_MSG
  BLOSC_LIBRARY BLOSC_INCLUDE_DIR)

IF(BLOSC_FOUND)
  SET(BLOSC_LIBRARIES ${BLOSC_LIBRARY})
  SET(BLOSC_INCLUDE_DIRS ${BLOSC_INCLUDE_DIR})
ELSE()
  SET(BLOSC_FOUND FALSE)
ENDIF()

MARK_AS_ADVANCED(
  BLOSC_INCLUDE_DIR
  BLOSC_LIBRARY
)

