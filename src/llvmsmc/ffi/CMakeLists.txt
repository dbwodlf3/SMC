cmake_minimum_required(VERSION 3.4.3)

SET(CMAKE_CXX_STANDARD 17)
SET(CMAKE_CXX_FLAGS "-Wall -fno-rtti -O0")

find_package(LLVM 10 REQUIRED CONFIG)
project(smc_ffi)

include_directories("${LLVM_INCLUDE_DIRS}")
add_definitions(${LLVM_DEFINITIONS})

list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")

message(STATUS "USING COMPILER : ${CMAKE_CXX_COMPILER_ID}")
message(STATUS "LLVM VERSION : ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

ADD_LIBRARY(util SHARED util.cpp detector.cpp test.cpp constraint.cpp)

llvm_map_components_to_libnames(llvm_libs support core irreader)

target_link_libraries(util ${llvm_libs})

if(Test)
  add_subdirectory(${PROJECT_SOURCE_DIR}/test)
endif()