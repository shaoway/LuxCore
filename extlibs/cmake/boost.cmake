set(BOOST_BUILD_TYPE_ARGS)
set(BOOST_LINK_FLAGE)

if(BUILD_STATIC)
  set(BOOST_BUILD_TYPE_ARGS
    -DBoost_USE_STATIC_LIBS=ON
    -DBoost_USE_STATIC_RUNTIME=ON
  )
  set(BOOST_LINK_FLAGE link=static)
else()
  set(BOOST_BUILD_TYPE_ARGS
    -DBoost_USE_STATIC_LIBS=OFF
    -DBoost_USE_STATIC_RUNTIME=OFF
  )
  set(BOOST_LINK_FLAGE link=shared)
endif()

set(BOOST_ADDRESS_MODEL 64)
set(BOOST_ARCHITECTURE x86)
set(DEFAULT_BOOST_FLAGS
  -DBoost_USE_MULTITHREADED=ON
  ${BOOST_BUILD_TYPE_ARGS}
  -DBOOST_ROOT=${LIBDIR}/boost
  -DBoost_NO_SYSTEM_PATHS=ON
  -DBoost_NO_BOOST_CMAKE=ON
  -DBoost_ADDITIONAL_VERSIONS=${BOOST_VERSION_SHORT}
  -DBOOST_LIBRARYDIR=${LIBDIR}/boost/lib/
  -DBoost_USE_DEBUG_PYTHON=ON
)

set(JAM_FILE ${BUILD_DIR}/boost.user-config.jam)
configure_file(${PATCH_DIR}/boost.user.jam.in ${JAM_FILE})
set(BOOST_PYTHON_OPTIONS
  --with-python
  --user-config=${JAM_FILE}
)

set(BOOST_HARVEST_CMD echo .)
set(BOOST_CONFIGURE_COMMAND ./bootstrap.sh)
set(BOOST_BUILD_COMMAND ./b2)
set(BOOST_BUILD_OPTIONS cxxflags=${PLATFORM_CXXFLAGS} --disable-icu boost.locale.icu=off)
set(BOOST_OPTIONS
  --with-filesystem
  --with-locale
  --with-thread
  --with-regex
  --with-chrono
  --with-system
  --with-date_time
  --with-wave
  --with-atomic
  --with-serialization
  --with-program_options
  --with-iostreams
  -sNO_BZIP2=1
  -sNO_LZMA=1
  -sNO_ZSTD=1
  ${BOOST_PYTHON_OPTIONS}
)

ExternalProject_Add(external_boost
  URL file://${PACKAGE_DIR}/${BOOST_FILE}
  DOWNLOAD_DIR ${DOWNLOAD_DIR}
  URL_HASH ${BOOST_HASH_TYPE}=${BOOST_HASH}
  PREFIX ${BUILD_DIR}/boost
  UPDATE_COMMAND  ""
  PATCH_COMMAND patch -p 1 -d ${BUILD_DIR}/boost/src/external_boost < ${PATCH_DIR}/boost.diff
  CONFIGURE_COMMAND ${BOOST_CONFIGURE_COMMAND}
  BUILD_COMMAND ${BOOST_BUILD_COMMAND} ${BOOST_BUILD_OPTIONS} -j8 architecture=${BOOST_ARCHITECTURE} address-model=${BOOST_ADDRESS_MODEL} ${BOOST_LINK_FLAGE} threading=multi ${BOOST_OPTIONS}  --prefix=${LIBDIR}/boost install
  BUILD_IN_SOURCE 1
  INSTALL_COMMAND "${BOOST_HARVEST_CMD}"
)

unset(BOOST_LINK_FLAGE)
unset(BOOST_BUILD_TYPE_ARGS)
