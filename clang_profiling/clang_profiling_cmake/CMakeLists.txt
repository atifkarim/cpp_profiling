cmake_minimum_required(VERSION 3.19)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Set Clang Compiler
# set(CMAKE_CXX_COMPILER "/usr/bin/clang++-10")
set(CMAKE_CXX_COMPILER clang++-10)

# SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pg -fprofile-instr-generate -fcoverage-mapping")
# SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -pg")
# SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -pg")

# if(NOT CMAKE_CXX_FLAGS)
#   set(CMAKE_CXX_FLAGS "-pg")
# endif(NOT CMAKE_CXX_FLAGS)

# if(NOT CMAKE_EXE_LINKER_FLAGS)
#   set(CMAKE_EXE_LINKER_FLAGS "-pg")
# endif(NOT CMAKE_EXE_LINKER_FLAGS)

# if(NOT CMAKE_SHARED_LINKER_FLAGS)
#   set(CMAKE_SHARED_LINKER_FLAGS "-pg")
# endif(NOT CMAKE_SHARED_LINKER_FLAGS)

project(clang_profiling_cmake)

if ("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
  MESSAGE("Clang")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  MESSAGE("GNU")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
  MESSAGE("Intel")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
  MESSAGE("MSVC")
endif()

if ("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
    add_compile_options(-pg -fprofile-instr-generate -fcoverage-mapping)
    add_link_options(-pg -fprofile-instr-generate -fcoverage-mapping)
endif()

set(MAIN_TARGET_NAME ${PROJECT_NAME})

# Include LLVM
# find_package(LLVM REQUIRED CONFIG)
# message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
# message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
# include_directories(${LLVM_INCLUDE_DIRS})
# add_definitions(${LLVM_DEFINITIONS})

# Create the C++ shared library
add_library(${MAIN_TARGET_NAME}_lib SHARED ${${PROJECT_NAME}_SOURCE_DIR}/src/test_gprof.cpp
                                           ${${PROJECT_NAME}_SOURCE_DIR}/src/test_gprof_new.cpp)

# Include directory for the target ${MAIN_TARGET_NAME}_lib
target_include_directories(${MAIN_TARGET_NAME}_lib PUBLIC ${PROJECT_SOURCE_DIR}/include)

# Target for the executable program
add_executable(${MAIN_TARGET_NAME}_exec ${PROJECT_SOURCE_DIR}/example/main.cpp)

# Set the name of the executable program file and the output directory
set_target_properties(${MAIN_TARGET_NAME}_exec PROPERTIES OUTPUT_NAME "clang_prof_exec")
set_target_properties(${MAIN_TARGET_NAME}_exec PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}/bin)
set_target_properties(${MAIN_TARGET_NAME}_exec PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}/bin)


# Set the name of the C++ shared library and the output directory
set_target_properties(${MAIN_TARGET_NAME}_lib PROPERTIES OUTPUT_NAME "clang_prof_lib")
set_target_properties(${MAIN_TARGET_NAME}_lib PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}/lib)
set_target_properties(${MAIN_TARGET_NAME}_lib PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}/lib)

# Find the libraries that correspond to the LLVM components
# that we wish to use
# llvm_map_components_to_libnames(llvm_libs support core irreader)

# Link the client executable target to client library
target_link_libraries(${MAIN_TARGET_NAME}_exec ${MAIN_TARGET_NAME}_lib)
# target_link_libraries(${MAIN_TARGET_NAME}_exec ${MAIN_TARGET_NAME}_lib ${llvm_libs})
