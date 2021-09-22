if(PROJECT_IS_TOP_LEVEL)
  set(CMAKE_INSTALL_INCLUDEDIR include/learnopengl CACHE PATH "")
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package learnopengl)

install(
    TARGETS learnopengl_learnopengl
    EXPORT learnopenglTargets
    RUNTIME COMPONENT learnopengl_Runtime
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    learnopengl_INSTALL_CMAKEDIR "${CMAKE_INSTALL_DATADIR}/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(learnopengl_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${learnopengl_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT learnopengl_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${learnopengl_INSTALL_CMAKEDIR}"
    COMPONENT learnopengl_Development
)

install(
    EXPORT learnopenglTargets
    NAMESPACE learnopengl::
    DESTINATION "${learnopengl_INSTALL_CMAKEDIR}"
    COMPONENT learnopengl_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
