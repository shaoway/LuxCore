set(IMATH_EXTRA_ARGS
  -DBUILD_SHARED_LIBS=OFF
  -DBUILD_TESTING=OFF
  -DIMATH_STATIC_LIB_SUFFIX=
  -DIMATH_LIB_SUFFIX=
)

ExternalProject_Add(external_imath
  URL file://${PACKAGE_DIR}/${IMATH_FILE}
  DOWNLOAD_DIR ${DOWNLOAD_DIR}
  URL_HASH ${IMATH_HASH_TYPE}=${IMATH_HASH}
  PREFIX ${BUILD_DIR}/imath
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/imath ${DEFAULT_CMAKE_FLAGS} ${IMATH_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/imath
)
