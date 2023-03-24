set(OPENCOLORIO_BUILD_TYPE)

if (BUILD_STATIC)
  set(OPENCOLORIO_BUILD_TYPE
    -DBUILD_SHARED_LIBS=OFF
  )
else()
  set(OPENCOLORIO_BUILD_TYPE
    -DBUILD_SHARED_LIBS=ON
  )
endif()


set(OPENCOLORIO_EXTRA_ARGS
  ${OPENCOLORIO_BUILD_TYPE}
  -DOCIO_BUILD_APPS=OFF
  -DOCIO_BUILD_PYTHON=OFF
  -DOCIO_BUILD_NUKE=OFF
  -DOCIO_BUILD_JAVA=OFF
  -DOCIO_BUILD_DOCS=OFF
  -DOCIO_BUILD_TESTS=OFF
  -DOCIO_BUILD_GPU_TESTS=OFF
  -DOCIO_USE_SSE=ON
  -DOCIO_INSTALL_EXT_PACKAGES=NONE

  -Dexpat_ROOT=${LIBDIR}/expat
  -Dyaml-cpp_ROOT=${LIBDIR}/yamlcpp
  -Dyaml-cpp_VERSION=${YAMLCPP_VERSION}
  -Dpystring_ROOT=${LIBDIR}/pystring
  -DImath_ROOT=${LIBDIR}/imath
  -Dminizip-ng_ROOT=${LIBDIR}/minizipng
  -Dminizip-ng_INCLUDE_DIR=${LIBDIR}/minizipng/include
  -Dminizip-ng_LIBRARY=${LIBDIR}/minizipng/lib/libminizip.a
  -DZLIB_LIBRARY=${LIBDIR}/zlib/lib/libz.a
  -DZLIB_INCLUDE_DIR=${LIBDIR}/zlib/include/
  -Dpybind11_ROOT=${LIBDIR}/pybind11
)

ExternalProject_Add(external_opencolorio
  URL file://${PACKAGE_DIR}/${OPENCOLORIO_FILE}
  DOWNLOAD_DIR ${DOWNLOAD_DIR}
  URL_HASH ${OPENCOLORIO_HASH_TYPE}=${OPENCOLORIO_HASH}
  PREFIX ${BUILD_DIR}/opencolorio
  PATCH_COMMAND patch -p 1 -N -d ${BUILD_DIR}/opencolorio/src/external_opencolorio < ${PATCH_DIR}/opencolorio.diff
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/opencolorio ${DEFAULT_CMAKE_FLAGS} ${OPENCOLORIO_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/opencolorio
)

ExternalProject_Add_Step(external_opencolorio after_install
  COMMAND cp ${LIBDIR}/yamlcpp/lib/libyaml-cpp.a ${LIBDIR}/opencolorio/lib/
  COMMAND cp ${LIBDIR}/expat/lib/libexpat.a ${LIBDIR}/opencolorio/lib/
  DEPENDEES install
)

add_dependencies(
  external_opencolorio
  external_yamlcpp
  external_expat
  external_imath
  external_zlib
  external_minizipng
  external_pybind11
)

