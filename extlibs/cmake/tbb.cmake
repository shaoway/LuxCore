set(TBB_EXTRA_ARGS
  -DTBB_BUILD_SHARED=ON
  -DTBB_BUILD_TBBMALLOC=ON
  -DTBB_BUILD_TBBMALLOC_PROXY=ON
  -DTBB_BUILD_STATIC=OFF
  -DTBB_BUILD_TESTS=OFF
)
set(TBB_LIBRARY tbb)
set(TBB_STATIC_LIBRARY Off)

# CMake script for TBB from https://github.com/wjakob/tbb/blob/master/CMakeLists.txt
ExternalProject_Add(external_tbb
  URL file://${PACKAGE_DIR}/${TBB_FILE}
  DOWNLOAD_DIR ${DOWNLOAD_DIR}
  URL_HASH ${TBB_HASH_TYPE}=${TBB_HASH}
  PREFIX ${BUILD_DIR}/tbb
  PATCH_COMMAND COMMAND ${CMAKE_COMMAND} -E copy ${PATCH_DIR}/cmakelists_tbb.txt ${BUILD_DIR}/tbb/src/external_tbb/CMakeLists.txt && ${CMAKE_COMMAND} -E copy ${BUILD_DIR}/tbb/src/external_tbb/build/vs2013/version_string.ver ${BUILD_DIR}/tbb/src/external_tbb/build/version_string.ver.in
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/tbb ${DEFAULT_CMAKE_FLAGS} ${TBB_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/tbb
)
