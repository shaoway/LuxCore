if(NOT MINIZIPNG_ROOT AND NOT $ENV{MINIZIPNG_ROOT} STREQUAL "")
  set(MINIZIPNG_ROOT $ENV{MINIZIPNG_ROOT})
endif()

set(__minizipng_SEARCH_DIRS
  ${MINIZIPNG_ROOT}
  /opt/lib/minizipng
)

find_path(MINIZIPNG_INCLUDE_DIR
  NAMES
  minizip-ng/mz.h

  HINTS
  ${__minizipng_SEARCH_DIRS}

  PATH_SUFFIXES
  include
)

find_library(MINIZIPNG_LIBRARY
  NAMES
  minizip

  HINTS
  ${__minizipng_SEARCH_DIRS}

  PATH_SUFFIXES
  lib64 lib
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MiniZipNG DEFAULT_MSG
  MINIZIPNG_LIBRARY
)

if (MINIZIPNG_FOUND)
  set(MINIZIPNG_INCLUDE_DIRS ${MINIZIPNG_INCLUDE_DIR} ${MINIZIPNG_INCLUDE_DIR}/minizip-ng)
  set(MINIZIPNG_LIBRARIES ${MINIZIPNG_LIBRARY})
endif()
  
mark_as_advanced(MINIZIPNG_INCLUDE_DIR MINIZIPNG_LIBRARY)
