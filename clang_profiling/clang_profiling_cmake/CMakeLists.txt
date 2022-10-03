cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# set(CMAKE_C_COMPILER "clang++-10")
set(CMAKE_CXX_COMPILER "/usr/bin/clang++-10")
# set(CMAKE_C_COMPILER clang++-10)
set(CMAKE_CXX_COMPILER clang++-10)

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

# if (LLVM_BUILD_INSTRUMENTED OR LLVM_BUILD_INSTRUMENTED_COVERAGE OR
#     LLVM_ENABLE_IR_PGO)
#     MESSAGE("Clang is Working")
#   if(NOT LLVM_PROFILE_MERGE_POOL_SIZE)
#     # A pool size of 1-2 is probably sufficient on a SSD. 3-4 should be fine
#     # for spining disks. Anything higher may only help on slower mediums.
#     set(LLVM_PROFILE_MERGE_POOL_SIZE "4")
#   endif()
#   if(NOT LLVM_PROFILE_FILE_PATTERN)
#     if(NOT LLVM_PROFILE_DATA_DIR)
#       file(TO_NATIVE_PATH "${LLVM_BINARY_DIR}/profiles" LLVM_PROFILE_DATA_DIR)
#     endif()
#     file(TO_NATIVE_PATH "${LLVM_PROFILE_DATA_DIR}/%${LLVM_PROFILE_MERGE_POOL_SIZE}m.profraw" LLVM_PROFILE_FILE_PATTERN)
#   endif()
#   if(NOT LLVM_CSPROFILE_FILE_PATTERN)
#     if(NOT LLVM_CSPROFILE_DATA_DIR)
#       file(TO_NATIVE_PATH "${LLVM_BINARY_DIR}/csprofiles" LLVM_CSPROFILE_DATA_DIR)
#     endif()
#     file(TO_NATIVE_PATH "${LLVM_CSPROFILE_DATA_DIR}/%${LLVM_PROFILE_MERGE_POOL_SIZE}m.profraw" LLVM_CSPROFILE_FILE_PATTERN)
#   endif()
# endif()

set(MAIN_TARGET_NAME ${PROJECT_NAME})

find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

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

# Link the client executable target to client library
target_link_libraries(${MAIN_TARGET_NAME}_exec ${MAIN_TARGET_NAME}_lib)
