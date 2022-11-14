# References
# vcpkg examples
# * https://github.com/northwindtraders/beicode/blob/main/CMakeLists.txt
# * https://github.com/northwindtraders/beison/blob/main/CMakeLists.txt
# Another example
# * https://github.com/pabloariasal/modern-cmake-sample/blob/master/libjsonutils/CMakeLists.txt
# Docs
# * https://cliutils.gitlab.io/modern-cmake/chapters/install.html
#
# Setting up a package is way too complicated...
#
# This ended up being based on https://github.com/microsoft/GSL/blob/main/cmake/gsl_install.cmake
#

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

target_include_directories(serial-port PUBLIC $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

set( package_folder         "${package_name}" )
set( package_target         "${package_name}-targets" )
set( package_config         "${package_name}-config.cmake" )
set( package_config_in      "${package_name}-config.cmake.in" )
set( package_config_version "${package_name}-config-version.cmake" )

configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/${package_config_in}"
    "${CMAKE_CURRENT_BINARY_DIR}/${package_config}"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${package_folder}"
)
write_basic_package_version_file(
	"${CMAKE_CURRENT_BINARY_DIR}/${package_config_version}"
	VERSION ${PROJECT_VERSION}
	COMPATIBILITY SameMajorVersion
)
install(
    TARGETS ${package_name}
    EXPORT  ${package_target}
)
install(
    EXPORT      ${package_target}
    NAMESPACE   ${package_nspace}::
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${package_folder}"
)
install(
    EXPORT      ${package_target}
    FILE        "${package_name}-targets.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/${package_folder}"
)

install(
    FILES       "${CMAKE_CURRENT_BINARY_DIR}/${package_config}"
                "${CMAKE_CURRENT_BINARY_DIR}/${package_config_version}"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${package_folder}"
)
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
