set(IMGUI_SRCS
  imgui.cpp
  imgui_demo.cpp
  imgui_draw.cpp
  imgui_impl_glfw.cpp
  imgui_impl_opengl3.cpp
  imgui_tables.cpp
  imgui_widgets.cpp
  misc/freetype/imgui_freetype.cpp
  ImGuiFileDialog/ImGuiFileDialog.cpp
)

add_library(imgui ${IMGUI_SRCS})
target_include_directories(imgui PRIVATE
  ${FREETYPE_INCLUDE_DIRS}
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/ImGuiFileDialog
)
