set(OIIO_TOOLS OFF)
set(OPENIMAGEIO_LINKSTATIC -DLINKSTATIC=OFF)
set(OPENJPEG_FLAGS -DOpenJPEG_ROOT=${LIBDIR}/openjpeg)
set(PNG_LIBNAME libpng.a)

set(OPENIMAGEIO_EXTRA_ARGS
  -DBUILD_SHARED_LIBS=ON
  ${OPENIMAGEIO_LINKSTATIC}
  ${DEFAULT_BOOST_FLAGS}
  -DUSE_LIBSQUISH=OFF
  -DUSE_QT5=OFF
  -DUSE_NUKE=OFF
  -DUSE_OPENVDB=OFF
  -DUSE_BZIP2=OFF
  -DUSE_FREETYPE=OFF
  -DUSE_DCMTK=OFF
  -DUSE_LIBHEIF=OFF
  -DUSE_OPENGL=OFF
  -DUSE_TBB=OFF
  -DUSE_QT=OFF
  -DUSE_PYTHON=ON
  -DUSE_GIF=OFF
  -DUSE_OPENCV=OFF
  -DUSE_OPENJPEG=ON
  -DUSE_FFMPEG=OFF
  -DUSE_PTEX=OFF
  -DUSE_FREETYPE=OFF
  -DUSE_LIBRAW=OFF
  -DUSE_OPENCOLORIO=OFF
  -DUSE_WEBP=ON
  -DOIIO_BUILD_TOOLS=${OIIO_TOOLS}
  -DOIIO_BUILD_TESTS=OFF
  -DBUILD_TESTING=OFF
  -DZLIB_LIBRARY=${LIBDIR}/zlib/lib/libz.a
  -DZLIB_INCLUDE_DIR=${LIBDIR}/zlib/include
  -DPNG_LIBRARY=${LIBDIR}/png/lib/libpng.a
  -DPNG_PNG_INCLUDE_DIR=${LIBDIR}/png/include
  -DTIFF_LIBRARY=${LIBDIR}/tiff/lib/libtiff.a
  -DTIFF_INCLUDE_DIR=${LIBDIR}/tiff/include
  -DJPEG_LIBRARY=${LIBDIR}/jpeg/lib/libjpeg.a
  -DJPEG_INCLUDE_DIR=${LIBDIR}/jpeg/include
  ${OPENJPEG_FLAGS}
  -DOPENEXR_ILMTHREAD_LIBRARY=${LIBDIR}/openexr/lib/libIlmThread.a
  -DOPENEXR_IEX_LIBRARY=${LIBDIR}/openexr/lib/libIex.a
  -DOPENEXR_ILMIMF_LIBRARY=${LIBDIR}/openexr/lib/libIlmImf.a
  -DSTOP_ON_WARNING=OFF
  -DUSE_EXTERNAL_PUGIXML=ON
  -DPUGIXML_LIBRARY=${LIBDIR}/pugixml/lib/libpugixml.a
  -DPUGIXML_INCLUDE_DIR=${LIBDIR}/pugixml/include/
  -Dpugixml_DIR=${LIBDIR}/pugixml/lib/cmake/pugixml
  -DBUILD_MISSING_ROBINMAP=OFF
  -DBUILD_MISSING_FMT=OFF
  -Dfmt_ROOT=${LIBDIR}/fmt
  -DRobinmap_ROOT=${LIBDIR}/robinmap
  -DWebP_ROOT=${LIBDIR}/webp
  -DOpenEXR_ROOT=${LIBDIR}/openexr
  -DImath_ROOT=${LIBDIR}/imath
  -Dpybind11_ROOT=${LIBDIR}/pybind11
)

ExternalProject_Add(external_openimageio
  URL file://${PACKAGE_DIR}/${OPENIMAGEIO_FILE}
  DOWNLOAD_DIR ${DOWNLOAD_DIR}
  URL_HASH ${OPENIMAGEIO_HASH_TYPE}=${OPENIMAGEIO_HASH}
  PREFIX ${BUILD_DIR}/openimageio
  PATCH_COMMAND patch -p 1 -N -d ${BUILD_DIR}/openimageio/src/external_openimageio/ < ${PATCH_DIR}/openimageio.diff
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LIBDIR}/openimageio ${DEFAULT_CMAKE_FLAGS} ${OPENIMAGEIO_EXTRA_ARGS}
  INSTALL_DIR ${LIBDIR}/openimageio
)

add_dependencies(
  external_openimageio
  external_png
  external_zlib
  external_openexr
  external_imath
  external_jpeg
  external_boost
  external_tiff
  external_pugixml
  external_fmt
  external_robinmap
  external_openjpeg
  external_webp
  external_pybind11
)
