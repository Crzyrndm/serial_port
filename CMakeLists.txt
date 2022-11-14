cmake_minimum_required(VERSION 3.24)

project(serial-port
    VERSION 1.0.4
    LANGUAGES CXX
)

option(SERIAL_PORT_INSTALL "Generate and install serial-port target" ${PROJECT_IS_TOP_LEVEL})

add_library(${PROJECT_NAME})
add_library(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

target_sources(${PROJECT_NAME}
    PRIVATE
        include/serial_port/serial_port_info.h
        include/serial_port/serial_port.h
        src/serial_port.cpp
        src/serial_port_info.cpp
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

target_compile_features(${PROJECT_NAME}
    PUBLIC
        cxx_std_20
)

target_compile_definitions(${PROJECT_NAME}
    PRIVATE
        _CRT_SECURE_NO_WARNINGS
)

if(BUILD_SHARED_LIBS AND WIN32)
	target_compile_definitions(${PROJECT_NAME}
		PRIVATE "SERIAL_PORT_EXPORT=__declspec(dllexport)"
		INTERFACE "SERIAL_PORT_EXPORT=__declspec(dllimport)")
endif()

set_target_properties(${PROJECT_NAME} PROPERTIES DEBUG_POSTFIX "d")

###########################
# Packaging and installation

if (SERIAL_PORT_INSTALL)
    include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/serial_port_install.cmake)
endif()