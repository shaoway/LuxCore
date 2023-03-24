set(OIDN_BUILD_TYPE)

if(BUILD_STATIC)
  set(OIDN_BUILD_TYPE
    -DOIDN_STATIC_LIB=ON
  )
else()
  set(OIDN_BUILD_TYPE
    -DOIDN_STATIC_LIB=OFF
  )
endif()

set(OIDN_EXTRA_ARGS
  ${OIDN_BUILD_TYPE}
  -DOIDN_APPS=ON
  -DTBB_ROOT=${LIBDIR}/tbb
  -DISPC_EXECUTABLE=ispc
  -DOIDN_FILTER_RTLIGHTMAP=OFF
)

ExternalProject_Add(external_openimagedenoise
  URL file://${PACKAGE_DIR}/${OIDN_FILE}
  DOWNLOAD_DIR ${DOWNLOAD_DIR}
  URL_HASH ${OIDN_HASH_TYPE}=${OIDN_HASH}
  PREFIX ${BUILD_DIR}/openimagedenoise
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/openimagedenoise ${DEFAULT_CMAKE_FLAGS} ${OIDN_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/openimagedenoise
)

add_dependencies(
  external_openimagedenoise
  external_tbb
)

unset(OIDN_BUILD_TYPE)
