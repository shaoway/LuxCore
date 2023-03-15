function(download_source dep)
  set(TARGET_FILE ${${dep}_FILE})
  set(TARGET_HASH_TYPE ${${dep}_HASH_TYPE})
  set(TARGET_HASH ${${dep}_HASH})
  set(TARGET_URI  ${${dep}_URI})
  
  # Validate all required variables are set and give an explicit error message
  # rather than CMake erroring out later on with a more ambigious error.
  if(NOT DEFINED TARGET_FILE)
    message(FATAL_ERROR "${dep}_FILE variable not set")
  endif()
  if(NOT DEFINED TARGET_HASH)
    message(FATAL_ERROR "${dep}_HASH variable not set")
  endif()
  if(NOT DEFINED TARGET_HASH_TYPE)
    message(FATAL_ERROR "${dep}_HASH_TYPE variable not set")
  endif()
  if(NOT DEFINED TARGET_URI)
    message(FATAL_ERROR "${dep}_URI variable not set")
  endif()
  set(TARGET_FILE ${PACKAGE_DIR}/${TARGET_FILE})
  message("Checking source : ${dep} (${TARGET_FILE})")
  if(NOT EXISTS ${TARGET_FILE})
    message("Checking source : ${dep} - source not found downloading from ${TARGET_URI}")
    file(
      DOWNLOAD ${TARGET_URI} ${TARGET_FILE}
      TIMEOUT 1800  # seconds
      EXPECTED_HASH ${TARGET_HASH_TYPE}=${TARGET_HASH}
      TLS_VERIFY ON
      SHOW_PROGRESS
    )
  endif()
  if(EXISTS ${TARGET_FILE})
    # Sometimes the download fails, but that is not a
    # fail condition for "file(DOWNLOAD" it will warn about
    # a CRC mismatch and just carry on, we need to explicitly
    # catch this and remove the bogus 0 byte file so we can
    # retry without having to go find the file and manually
    # delete it.
    file(SIZE ${TARGET_FILE} TARGET_SIZE)
    if(${TARGET_SIZE} EQUAL 0)
      file(REMOVE ${TARGET_FILE})
      message(FATAL_ERROR "for ${TARGET_FILE} file size 0, download likely failed, deleted...")
    endif()

    file(${TARGET_HASH_TYPE} ${TARGET_FILE} LOCAL_HASH)
    if(NOT ${TARGET_HASH} STREQUAL ${LOCAL_HASH})
      message(FATAL_ERROR "${TARGET_FILE} ${TARGET_HASH_TYPE} mismatch\nExpected\t: ${TARGET_HASH}\nActual\t: ${LOCAL_HASH}")
    endif()
  endif()
endfunction(download_source)

download_source(FMT)
download_source(ZLIB)
download_source(SPDLOG)
download_source(EXPAT)
download_source(YAMLCPP)
download_source(JSON)
download_source(BLOSC)
download_source(PNG)
download_source(BOOST)
download_source(TBB)
download_source(EMBREE)
download_source(IMATH)
download_source(OPENEXR)
download_source(BZIP2)
download_source(MINIZIPNG)
download_source(PYBIND11)
download_source(OPENCOLORIO)
download_source(OPENSUBDIV)
download_source(ROBINMAP)
download_source(JPEG)
download_source(OPENJPEG)
download_source(TIFF)
download_source(PUGIXML)
download_source(WEBP)
download_source(OPENIMAGEIO)
download_source(OIDN)
download_source(OPENVDB)

