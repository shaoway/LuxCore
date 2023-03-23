set(OIDN_EXTRA_ARGS
  -DOIDN_APPS=ON
  -DTBB_ROOT=${LIBDIR}/tbb
  -DTBB_STATIC_LIB=OFF
  -DOIDN_STATIC_LIB=OFF
  -DOIDN_STATIC_RUNTIME=OFF
  -DISPC_EXECUTABLE=ispc
  -DOIDN_FILTER_RTLIGHTMAP=OFF
  -Dtbb_LIBRARY_RELEASE=${LIBDIR}/tbb/lib/libtbb.so
  -Dtbbmalloc_LIBRARY_RELEASE=${LIBDIR}/tbb/lib/libtbbmalloc.so
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
