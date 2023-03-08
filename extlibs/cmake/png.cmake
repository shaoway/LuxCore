set(PNG_EXTRA_ARGS
  -DZLIB_LIBRARY=${LIBDIR}/zlib/lib/libz.a
  -DZLIB_INCLUDE_DIR=${LIBDIR}/zlib/include/
  -DPNG_STATIC=ON
  -DPNG_SHARED=OFF
)

ExternalProject_Add(external_png
  URL file://${PACKAGE_DIR}/${PNG_FILE}
  DOWNLOAD_DIR ${DOWNLOAD_DIR}
  URL_HASH ${PNG_HASH_TYPE}=${PNG_HASH}
  PREFIX ${BUILD_DIR}/png
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/png ${DEFAULT_CMAKE_FLAGS} ${PNG_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/png
)

add_dependencies(
  external_png
  external_zlib
)
