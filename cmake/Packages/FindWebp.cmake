# SPDX-License-Identifier: BSD-3-Clause
# - Find Webp library
# Find the native webp includes and library
# This module defines
#  WEBP_INCLUDE_DIRS, webp include dirs
#
#  WEBP_LIBRARIES, libraries to link against to use webp.
#  WEBP_ROOT, The base directory to search for webp.
#                        This can also be an environment variable.
#  WEBP_FOUND, If false, do not try to use webp

# If WEBP_ROOT was defined in the environment, use it.
if(NOT WEBP_ROOT AND NOT $ENV{WEBP_ROOT} STREQUAL "")
  set(WEBP_ROOT $ENV{WEBP_ROOT})
endif()

set(_webp_SEARCH_DIRS
  ${WEBP_ROOT}
  /opt/lib/webp
)

find_path(WEBP_INCLUDE_DIR
  NAMES
  webp
  HINTS
  ${_webp_SEARCH_DIRS}
  PATH_SUFFIXES
  include
)

set(_webp_FIND_COMPONENTS
  webp
  webpdecoder
  webpdemux
  webpmux
)
set(_webp_LIBRARIES)
foreach(COMPONENT ${_webp_FIND_COMPONENTS})
  string(TOUPPER ${COMPONENT} UPPERCOMPONENT)

  find_library(WEBP_${UPPERCOMPONENT}_LIBRARY
    NAMES
    ${COMPONENT}
    HINTS
    ${_webp_SEARCH_DIRS}
    PATH_SUFFIXES
    lib64 lib    
  )
  list(APPEND _webp_LIBRARIES "${WEBP_${UPPERCOMPONENT}_LIBRARY}")
endforeach()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Webp DEFAULT_MSG
  _webp_LIBRARIES WEBP_INCLUDE_DIR)

if (WEBP_FOUND)
  set(WEBP_LIBRARIES ${_webp_LIBRARIES})
  set(WEBP_INCLUDE_DIRS ${WEBP_INCLUDE_DIR} ${WEBP_INCLUDE_DIR}/wepb)
endif()

mark_as_advanced(WEBP_INCLUDE_DIR)
foreach(COMPONENT ${_webp_FIND_COMPONENTS})
  string(TOUPPER ${COMPONENT} UPPERCOMPONENT)
  mark_as_advanced(WEBP_${UPPERCOMPONENT}_LIBRARY)
endforeach()

unset(_webp_SEARCH_DIRS)
unset(_webp_FIND_COMPONENTS)
unset(_webp_LIBRARIES)

