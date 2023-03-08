set(OPENVDB_EXTRA_ARGS
  ${DEFAULT_BOOST_FLAGS}
  -DUSE_STATIC_DEPENDENCIES=OFF   # This is the global toggle for static libs
  # Once the above switch is off, you can set it
  # for each individual library below.
  -DBLOSC_USE_STATIC_LIBS=ON
  -DTBB_USE_STATIC_LIBS=OFF
  -DBoost_USE_STATIC_LIBS=OFF
  -DZLIB_LIBRARY=${LIBDIR}/zlib/lib/libz.a
  -DZLIB_INCLUDE_DIR=${LIBDIR}/zlib/include/
  -DBlosc_INCLUDE_DIR=${LIBDIR}/blosc/include/
  -DBlosc_LIBRARY=${LIBDIR}/blosc/lib/libblosc.a
  -DBlosc_LIBRARY_RELEASE=${LIBDIR}/blosc/lib/libblosc.a
  -DBlosc_LIBRARY_DEBUG=${LIBDIR}/blosc/lib/libblosc.a
  -DOPENVDB_BUILD_UNITTESTS=OFF
  -DOPENVDB_BUILD_NANOVDB=ON
  -DNANOVDB_BUILD_TOOLS=OFF
  -DBlosc_ROOT=${LIBDIR}/blosc/
  -DTBB_ROOT=${LIBDIR}/tbb/
  -DTbb_INCLUDE_DIR=${LIBDIR}/tbb/include
  -DTbb_LEGACY_INCLUDE_DIR=${LIBDIR}/tbb/include
  -DOPENVDB_CORE_SHARED=ON
  -DOPENVDB_CORE_STATIC=OFF
  -DOPENVDB_BUILD_BINARIES=OFF
  -DBLOSC_USE_STATIC_LIBS=ON
  -DUSE_NANOVDB=ON
  -DImath_ROOT=${LIBDIR}/imath
  -DUSE_IMATH_HALF=ON
)

ExternalProject_Add(openvdb
  URL file://${PACKAGE_DIR}/${OPENVDB_FILE}
  DOWNLOAD_DIR ${DOWNLOAD_DIR}
  URL_HASH ${OPENVDB_HASH_TYPE}=${OPENVDB_HASH}
  PREFIX ${BUILD_DIR}/openvdb
  PATCH_COMMAND patch -p 1 -d ${BUILD_DIR}/openvdb/src/openvdb < ${PATCH_DIR}/openvdb.diff
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/openvdb ${DEFAULT_CMAKE_FLAGS} ${OPENVDB_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/openvdb
)

add_dependencies(
  openvdb
  external_tbb
  external_boost
  external_zlib
  external_blosc
)
