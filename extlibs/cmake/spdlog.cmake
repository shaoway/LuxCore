set(SPDLOG_EXTRA_ARGS
  -DSPDLOG_BUILD_EXAMPLE=OFF
  -DSPDLOG_FMT_EXTERNAL=ON
  -Dfmt_ROOT=${LIBDIR}/fmt
  -Dfmt_DIR=${LIBDIR}/fmt/lib/cmake/fmt
)

ExternalProject_Add(external_spdlog
  URL file://${PACKAGE_DIR}/${SPDLOG_FILE}
  URL_HASH ${SPDLOG_HASH_TYPE}=${SPDLOG_HASH}
  PREFIX ${BUILD_DIR}/spdlog
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/spdlog ${DEFAULT_CMAKE_FLAGS} ${SPDLOG_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/spdlog
)

add_dependencies( external_spdlog
  external_fmt
)

