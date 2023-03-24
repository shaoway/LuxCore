set(TBB_BUILD_TYPE)
if (BUILD_STATIC)
  set(TBB_BUILD_TYPE
    -DTBB_BUILD_SHARED=OFF
    -DTBB_BUILD_STATIC=ON    
  )
else()
  set(TBB_BUILD_TYPE
    -DTBB_BUILD_SHARED=ON
    -DTBB_BUILD_STATIC=OFF
  )
endif()

set(TBB_EXTRA_ARGS
  ${TBB_BUILD_TYPE}
  -DTBB_BUILD_TBBMALLOC=ON
  -DTBB_BUILD_TBBMALLOC_PROXY=ON
  -DTBB_BUILD_TESTS=OFF
)
set(TBB_LIBRARY tbb)

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

if (BUILD_STATIC)
  ExternalProject_Add_Step(external_tbb after_install
    COMMAND ${CMAKE_COMMAND} -E rm -f ${LIBDIR}/tbb/lib/libtbb.so
                                      ${LIBDIR}/tbb/lib/libtbbmalloc_proxy.so
                                      ${LIBDIR}/tbb/lib/libtbbmalloc.so
    COMMAND ${CMAKE_COMMAND} -E rename ${LIBDIR}/tbb/lib/libtbb_static.a ${LIBDIR}/tbb/lib/libtbb.a
    COMMAND ${CMAKE_COMMAND} -E rename ${LIBDIR}/tbb/lib/libtbbmalloc_static.a ${LIBDIR}/tbb/lib/libtbbmalloc.a
    COMMAND ${CMAKE_COMMAND} -E rename ${LIBDIR}/tbb/lib/libtbbmalloc_proxy_static.a ${LIBDIR}/tbb/lib/libtbbmalloc_proxy.a
    DEPENDEES install
  )

endif()

unset(TBB_BUILD_TYPE)
