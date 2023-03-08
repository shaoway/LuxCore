################################################################################
# Copyright 1998-2020 by authors (see AUTHORS.txt)
#
#   This file is part of LuxCoreRender.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

################################################################################
#
# Binary samples directory
#
################################################################################

if (WIN32)
	
  # For MSVC moving exe files gets done automatically
  # If there is someone compiling on windows and
  # not using msvc (express is free) - feel free to implement

else ()
  set(CMAKE_INSTALL_PREFIX .)
endif()
      
if(PLATFORM_BUNDLED_LIBRARIES AND TARGETDIR_LIB)
  file(INSTALL ${PLATFORM_BUNDLED_LIBRARIES}
    DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${TARGETDIR_LIB}"
  )
endif()

