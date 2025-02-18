set(JSON_EXTRA_ARGS
  -DJSON_BuildTests=OFF
)

ExternalProject_Add(external_json
  URL file://${PACKAGE_DIR}/${JSON_FILE}
  URL_HASH ${JSON_HASH_TYPE}=${JSON_HASH}
  PREFIX ${BUILD_DIR}/json
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/json ${DEFAULT_CMAKE_FLAGS} ${JSON_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/json
)
