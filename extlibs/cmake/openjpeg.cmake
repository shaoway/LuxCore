set(OPENJPEG_EXTRA_ARGS ${DEFAULT_CMAKE_FLAGS})
set(OPENJPEG_EXTRA_ARGS
  ${OPENJPEG_EXTRA_ARGS}
  -DBUILD_SHARED_LIBS=OFF
  -DBUILD_CODEC=OFF
)

ExternalProject_Add(external_openjpeg
  URL file://${PACKAGE_DIR}/${OPENJPEG_FILE}
  DOWNLOAD_DIR ${DOWNLOAD_DIR}
  URL_HASH ${OPENJPEG_HASH_TYPE}=${OPENJPEG_HASH}
  PREFIX ${BUILD_DIR}/openjpeg
  CONFIGURE_COMMAND ${CONFIGURE_ENV} && cd ${BUILD_DIR}/openjpeg/src/external_openjpeg-build && ${CMAKE_COMMAND} ${OPENJPEG_EXTRA_ARGS} -DCMAKE_INSTALL_PREFIX=${LIBDIR}/openjpeg ${BUILD_DIR}/openjpeg/src/external_openjpeg
  BUILD_COMMAND ${CONFIGURE_ENV} && cd ${BUILD_DIR}/openjpeg/src/external_openjpeg-build/ && make -j4
  INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${BUILD_DIR}/openjpeg/src/external_openjpeg-build/ && make install
  INSTALL_DIR ${LIBDIR}/openjpeg
)

set(OPENJPEG_LIBRARY libopenjp2.a)
