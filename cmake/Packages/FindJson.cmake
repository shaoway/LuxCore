if(NOT JSON_ROOT AND NOT $ENV{JSON_ROOT} STREQUAL "")
  set(JSON_ROOT $ENV{JSON_ROOT})
endif()

set(_json_SEARCH_DIRS
  ${JSON_ROOT}
  /opt/lib/
)

find_path(JSON_INCLUDE_DIR
  NAMES
  nlohmann/json.hpp
  
  HINTS
  ${_json_SEARCH_DIRS}
  
  PATH_SUFFIXES
  include
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Json DEFAULT_MSG
    JSON_INCLUDE_DIR)

if(JSON_FOUND)
  set(JSON_INCLUDE_DIRS ${JSON_INCLUDE_DIR})
else()
  set(JSON_JSON_FOUND FALSE)
endif()

mark_as_advanced(
  JSON_INCLUDE_DIR
)
