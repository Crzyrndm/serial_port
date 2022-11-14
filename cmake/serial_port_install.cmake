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

set(serial_port_install_config_dir "${CMAKE_INSTALL_LIBDIR}/${PROJECT_NAME}")
set(serial_port_install_data_dest "${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}")
set(serial_port_package_config_file "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config.cmake")
set(serial_port_package_config_version_file "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake")
set(serial_port_export "${PROJECT_NAME}-targets")

configure_package_config_file(cmake/serial_port_config.cmake.in
	${serial_port_package_config_file}
	INSTALL_DESTINATION ${serial_port_install_data_dest}
)
write_basic_package_version_file(
	${serial_port_package_config_version_file}
	VERSION ${PROJECT_VERSION}
	COMPATIBILITY SameMajorVersion
)
install(
	FILES
		${serial_port_package_config_file}
		${serial_port_package_config_version_file}
	DESTINATION
		${serial_port_install_data_dest}
)

install(TARGETS ${PROJECT_NAME}
    EXPORT ${serial_port_export}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(EXPORT ${serial_port_export}
    FILE
        ${serial_port_export}.cmake
    NAMESPACE
        ${PROJECT_NAME}::
    DESTINATION
        ${serial_port_install_config_dir}
)