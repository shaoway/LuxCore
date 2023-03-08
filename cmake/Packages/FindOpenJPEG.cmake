if(NOT OPENJPEG_ROOT AND NOT $ENV{OPENJPEG_ROOT} STREQUAL "")
  set(OPENJPEG_ROOT $ENV{OPENJPEG_ROOT})
endif()

set(__openjpeg_SEARCH_DIRS
  ${OPENJPEG_ROOT}
  /opt/lib/openjpeg
)

find_path(OPENJPEG_INCLUDE_DIR
  NAMES
  openjpeg-2.5/openjpeg.h

  HINTS
  ${__openjpeg_SEARCH_DIRS}

  PATH_SUFFIXES
  include
)

find_library(OPENJPEG_LIBRARY
  NAMES
  openjp2

  HINTS
  ${__openjpeg_SEARCH_DIRS}

  PATH_SUFFIXES
  lib64 lib
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenJPEG DEFAULT_MSG
  OPENJPEG_LIBRARY
)

if (OPENJPEG_FOUND)
  set(OPENJPEG_INCLUDE_DIRS ${OPENJPEG_INCLUDE_DIR} ${OPENJPEG_INCLUDE_DIR}/openjpeg-2.5)
  set(OPENJPEG_LIBRARIES ${OPENJPEG_LIBRARY})
endif()
  
mark_as_advanced(OPENJPEG_INCLUDE_DIR OPENJPEG_LIBRARY)
