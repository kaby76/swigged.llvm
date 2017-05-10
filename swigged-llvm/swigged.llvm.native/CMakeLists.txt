cmake_minimum_required(VERSION 3.4.3)
project (swigged-llvm-native)

find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")


# Set your project compile flags.
# E.g. if using the C++ header files
# you will need to enable C++11 support
# for your compiler.
set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")


include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

# Set specific targets.
set(LLVM_BUILD_TARGETS
    MSIL
	X86)

# Now build our tools
# add_library(llvm-wrap STATIC LLVM_wrap.cpp)
add_library(swigged-llvm-native MODULE LLVM_wrap.cpp)

# Find the libraries that correspond to the LLVM components
# that we wish to use
llvm_map_components_to_libnames(llvm_libs support core irreader mcparser bitreader mc option mcjit native linker ipo executionengine runtimedyld)


# Link against LLVM libraries
target_link_libraries(swigged-llvm-native ${llvm_libs})
set_target_properties(swigged-llvm-native PROPERTIES PREFIX "")
