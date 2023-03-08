if(NOT IMATH_ROOT AND NOT $ENV{IMATH_ROOT} STREQUAL "")
  set(IMATH_ROOT $ENV{IMATH_ROOT})
endif()

set(_imath_SEARCH_DIRS
  ${IMATH_ROOT}
  /opt/lib/imath
)

find_path(IMATH_INCLUDE_DIR
  NAMES
  Imath/half.h
  
  HINTS
  ${_imath_SEARCH_DIRS}
  
  PATH_SUFFIXES
  include
)

find_library(IMATH_LIBRARY
  NAMES
  Imath

  HINTS
  ${_imath_SEARCH_DIRS}

  PATH_SUFFIXES
  lib64 lib
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Imath DEFAULT_MSG
    IMATH_LIBRARY IMATH_INCLUDE_DIR)

if(IMATH_FOUND)
  set(IMATH_LIBRARIES ${IMATH_LIBRARY})
  set(IMATH_INCLUDE_DIRS ${IMATH_INCLUDE_DIR} ${IMATH_INCLUDE_DIR}/Imath)
else()
  set(IMATH_IMATH_FOUND FALSE)
endif()

mark_as_advanced(
  IMATH_INCLUDE_DIR
  IMATH_LIBRARY
)
