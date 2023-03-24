ExternalProject_Add(external_zlib
  URL file://${PACKAGE_DIR}/${ZLIB_FILE}
  URL_HASH ${ZLIB_HASH_TYPE}=${ZLIB_HASH}
  PREFIX ${BUILD_DIR}/zlib
  CMAKE_ARGS -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_INSTALL_PREFIX=${LIBDIR}/zlib ${DEFAULT_CMAKE_FLAGS}
  INSTALL_DIR ${LIBDIR}/zlib
)

ExternalProject_Add_Step(external_zlib after_install
  COMMAND ${CMAKE_COMMAND} -E rm -f ${LIBDIR}/zlib/lib/libz.so ${LIBDIR}/zlib/lib/libz.so.1 ${LIBDIR}/zlib/lib/libz.so.1.2.13
  DEPENDEES install
)

