if(NOT SPDLOG_ROOT AND NOT $ENV{SPDLOG_ROOT} STREQUAL "")
  set(SPDLOG_ROOT $ENV{SPDLOG_ROOT})
endif()

set(__spdlog_SEARCH_DIRS
  ${SPDLOG_ROOT}
  /opt/lib/spdlog
)

find_path(SPDLOG_INCLUDE_DIR
  NAMES
  spdlog/spdlog.h

  HINTS
  ${__spdlog_SEARCH_DIRS}

  PATH_SUFFIXES
  include
)

find_library(SPDLOG_LIBRARY
  NAMES
  spdlog

  HINTS
  ${__spdlog_SEARCH_DIRS}

  PATH_SUFFIXES
  lib64 lib
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Spdlog DEFAULT_MSG
  SPDLOG_LIBRARY
)

if (SPDLOG_FOUND)
  set(SPDLOG_INCLUDE_DIRS ${SPDLOG_INCLUDE_DIR} ${SPDLOG_INCLUDE_DIR}/spdlog)
  set(SPDLOG_LIBRARIES ${SPDLOG_LIBRARY})
endif()
  
mark_as_advanced(SPDLOG_INCLUDE_DIR SPDLOG_LIBRARY)
