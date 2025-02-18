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

#############################################################################
#
# GLFW library
#
#############################################################################
find_package(glfw3 REQUIRED)
find_package(Freetype REQUIRED)
add_subdirectory(imgui)

#############################################################################
#
# luxcore UI binary
#
#############################################################################

set(LUXCOREUI_SRCS
	luxcoreui.cpp
	luxcoreapp.cpp
	uiloop.cpp
	uikeys.cpp
	uimenu.cpp
	uimouse.cpp
	helpwindow.cpp
	logwindow.cpp
	objectwindow.cpp
	objecteditorwindow.cpp
	acceleratorwindow.cpp
	epsilonwindow.cpp
	filmchannelswindow.cpp
	filmoutputswindow.cpp
	filmradiancegroupswindow.cpp
	imagewindow.cpp
	lightstrategywindow.cpp
	ocldevicewindow.cpp
	pixelfilterwindow.cpp
	renderenginewindow.cpp
	samplerwindow.cpp
	haltconditionswindow.cpp
	statswindow.cpp
	importancewindow.cpp
	bake.cpp
	resources/luxlogo_bg.cpp
      )

add_executable(luxcoreui ${LUXCOREUI_SRCS})

target_include_directories(luxcoreui
  PRIVATE
  imgui/
  imgui/ImGuiFileDialog
)

if(APPLE)

  target_link_libraries(luxcoreui
    luxcoreui
    ${GLFW_LIBRARIES}
    ${OPENGL_LIBRARIES}
    ${Boost_LIBRARIES}
  )
else()
  target_link_libraries(luxcoreui PRIVATE
    luxcore
    imgui
    OpenGL::GL
    glfw
    ${FREETYPE_LIBRARIES}
    ${Boost_LIBRARIES}
  )
endif()

