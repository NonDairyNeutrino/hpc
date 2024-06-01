# Portions of this code were generated using ChatGPT3.5
cmake_minimum_required(VERSION 3.7)
project("matrix_power" LANGUAGES "Fortran")

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/bin)

file(GLOB SOURCES "src/*.f90")

# pass compiler flags e.g. optimization options
add_compile_options(-O0)
# Generate the executable from the source files
add_executable(main ${SOURCES})
