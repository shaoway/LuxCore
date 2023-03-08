if(NOT FMT_ROOT AND NOT $ENV{FMT_ROOT} STREQUAL "")
  set(FMT_ROOT $ENV{FMT_ROOT})
endif()

set(_fmt_SEARCH_DIRS
  ${FMT_ROOT}
  /opt/lib/
)

find_path(FMT_INCLUDE_DIR
  NAMES
  fmt/format.h
  
  HINTS
  ${_fmt_SEARCH_DIRS}
  
  PATH_SUFFIXES
  include
)

find_library(FMT_LIBRARY
  NAMES
    fmt
  HINTS
    ${_tbb_SEARCH_DIRS}
  PATH_SUFFIXES
    lib64 lib
  )


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Fmt DEFAULT_MSG
    FMT_INCLUDE_DIR)

if(FMT_FOUND)
  set(FMT_INCLUDE_DIRS ${FMT_INCLUDE_DIR} ${FMT_INCLUDE_DIR}/fmt)
  set(FMT_LIBRARIES ${FMT_LIBRARY})
else()
  set(FMT_FMT_FOUND FALSE)
endif()

mark_as_advanced(
  FMT_INCLUDE_DIR
)
