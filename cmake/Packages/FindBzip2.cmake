if(NOT BZIP2_ROOT AND NOT $ENV{BZIP2_ROOT} STREQUAL "")
  set(BZIP2_ROOT $ENV{BZIP2_ROOT})
endif()

set(__bz2_SEARCH_DIRS
  ${BZIP2_ROOT}
  /opt/lib/bzip2
)

find_path(BZIP2_INCLUDE_DIR
  NAMES
  bzlib.h

  HINTS
  ${__bz2_SEARCH_DIRS}

  PATH_SUFFIXES
  include
)

find_library(BZIP2_LIBRARY
  NAMES
  bz2

  HINTS
  ${__bz2_SEARCH_DIRS}

  PATH_SUFFIXES
  lib64 lib
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Bzip2 DEFAULT_MSG
  BZIP2_LIBRARY
)

if (BZIP2_FOUND)
  set(BZIP2_INCLUDE_DIRS ${BZIP2_INCLUDE_DIR})
  set(BZIP2_LIBRARIES ${BZIP2_LIBRARY})
endif()
  
mark_as_advanced(BZIP2_INCLUDE_DIR BZIP2_LIBRARY)
