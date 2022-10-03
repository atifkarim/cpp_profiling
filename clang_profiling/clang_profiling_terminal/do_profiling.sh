clang++-10 -O2 -fprofile-instr-generate test_gprof.cpp test_gprof_new.cpp -o code
LLVM_PROFILE_FILE="code-%h.profraw" ./code
llvm-profdata merge -output=code.profdata code-*.profraw
clang++-10 -O2 -fprofile-instr-use=code.profdata test_gprof.cpp test_gprof_new.cpp -o code
