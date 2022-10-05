C++ Profiling
==============

This repo will show method of c++ profiling using Clang

## Important CMake Addition

- `SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-instr-generate -fcoverage-mapping")`
- Here, also can use `-pg` for `gprof` profile tool
- Important resources are found in
    - [gprof with cmake](https://stackoverflow.com/questions/26491948/how-to-use-gprof-with-cmake)
    - [CMake command which can be used without adding stuff in CMakeLists.txt](https://stackoverflow.com/a/40922025/10634362)
    - [CMakeLists.txt file is modified by adding compilation flag for gprof](https://stackoverflow.com/a/26657026/10634362)
## Resource

- [C++ Performance Analysis & Profiling Tools](https://kusemanohar.wordpress.com/2012/08/13/c-performance-analysis-profiling-tools/)
- [Profiny](https://sercantutar.github.io/profiny/). I have not worked with it though.
- [Add LLVM to project using cmake](https://stackoverflow.com/questions/30867712/add-llvm-to-project-using-cmake)
