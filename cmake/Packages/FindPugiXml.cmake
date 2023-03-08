if(NOT PUGIXML_ROOT AND NOT $ENV{PUGIXML_ROOT} STREQUAL "")
  set(PUGIXML_ROOT $ENV{PUGIXML_ROOT})
endif()

set(_pugixml_SEARCH_DIRS
  ${PUGIXML_ROOT}
  /opt/lib/pugixml
)

find_path(PUGIXML_INCLUDE_DIR
  NAMES
  pugixml.hpp
  
  HINTS
  ${_pugixml_SEARCH_DIRS}
  
  PATH_SUFFIXES
  include
)

find_library(PUGIXML_LIBRARY
  NAMES
    pugixml
  HINTS
    ${_pugixml_SEARCH_DIRS}
  PATH_SUFFIXES
    lib64 lib
  )


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(PugiXml DEFAULT_MSG
    PUGIXML_INCLUDE_DIR)

if(PUGIXML_FOUND)
  set(PUGIXML_INCLUDE_DIRS ${PUGIXML_INCLUDE_DIR})
  set(PUGIXML_LIBRARIES ${PUGIXML_LIBRARY})
endif()

mark_as_advanced(
  PUGIXML_INCLUDE_DIR
)
