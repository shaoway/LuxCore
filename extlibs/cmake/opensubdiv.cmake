set(OPENSUBDIV_TBB_LIB)
if(BUILD_STATIC)
  set(OPENSUBDIV_TBB_LIB ${LIBDIR}/tbb/lib/libtbb.a)
else()
  set(OPENSUBDIV_TBB_LIB ${LIBDIR}/tbb/lib/libtbb.so)
endif()

set(OPENSUBDIV_EXTRA_ARGS
  -DNO_LIB=OFF
  -DNO_EXAMPLES=ON
  -DNO_TUTORIALS=ON
  -DNO_REGRESSION=ON
  -DNO_PTEX=ON
  -DNO_DOC=ON
  -DNO_OMP=OFF
  -DNO_TBB=OFF
  -DNO_CUDA=ON
  -DNO_OPENCL=ON
  -DNO_CLEW=ON
  -DNO_OPENGL=ON
  -DNO_METAL=ON
  -DNO_DX=ON
  -DNO_TESTS=ON
  -DNO_GLTESTS=ON
  -DNO_GLEW=ON
  -DNO_GLFW=ON
  -DNO_GLFW_X11=ON
  -DTBB_INCLUDE_DIR=${LIBDIR}/tbb/include
  -DTBB_tbb_LIBRARY=${OPENSUBDIV_TBB_LIB}
)

ExternalProject_Add(external_opensubdiv
  URL file://${PACKAGE_DIR}/${OPENSUBDIV_FILE}
  DOWNLOAD_DIR ${DOWNLOAD_DIR}
  URL_HASH ${OPENSUBDIV_HASH_TYPE}=${OPENSUBDIV_HASH}
  PREFIX ${BUILD_DIR}/opensubdiv
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/opensubdiv -Wno-dev ${DEFAULT_CMAKE_FLAGS} ${OPENSUBDIV_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/opensubdiv
)

if (BUILD_STATIC)
  ExternalProject_Add_Step(external_opensubdiv after_install
    COMMAND ${CMAKE_COMMAND} -E rm -f ${LIBDIR}/opensubdiv/lib/libosdCPU.so ${LIBDIR}/opensubdiv/lib/libosdCPU.so.3.5.0
    DEPENDEES install
  )
endif()

add_dependencies(
  external_opensubdiv
  external_tbb
)


unset(OPENSUBDIV_TBB_LIB)
