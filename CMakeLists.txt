cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    learnopengl
    VERSION 0.1.0
    DESCRIPTION "Short description"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES C CXX
)

docs_early_return()

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

find_package(glfw3 REQUIRED)
find_package(OpenGL REQUIRED)


# ---- Declare library ----

add_library(
    glad_lib STATIC
    source/glad/glad.c
)

target_include_directories(
    glad_lib ${learnopengl_warning_guard}
    PRIVATE
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/source/glad>"
)

add_library(
    learnopengl_lib STATIC
    source/opengl_sample/lib.cpp
)

target_include_directories(
    learnopengl_lib ${learnopengl_warning_guard}
    PRIVATE
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/source/glad>"
)

target_include_directories(
    learnopengl_lib ${learnopengl_warning_guard}
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/source/opengl_sample>"
)

target_compile_features(learnopengl_lib PUBLIC cxx_std_20)

target_link_libraries(learnopengl_lib PRIVATE glad_lib glfw OpenGL::GL ${CMAKE_DL_LIBS})

# ---- Declare executable ----

add_executable(learnopengl_learnopengl source/main.cpp)
add_executable(learnopengl::learnopengl ALIAS learnopengl_learnopengl)

set_target_properties(
    learnopengl_learnopengl PROPERTIES
    OUTPUT_NAME learnopengl
    EXPORT_NAME learnopengl
)

target_compile_features(learnopengl_learnopengl PRIVATE cxx_std_20)

target_link_libraries(learnopengl_learnopengl PRIVATE learnopengl_lib)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT learnopengl_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of learnopengl"
  )
endif()

include(cmake/dev-mode.cmake)
