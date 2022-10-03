clang++-10 -fprofile-instr-generate -fcoverage-mapping test_gprof.cpp test_gprof_new.cpp -o code_coverage
LLVM_PROFILE_FILE="code_coverage.profraw" ./code_coverage
llvm-profdata merge -sparse code_coverage.profraw -o code_coverage.profdata
#llvm-cov show ./code_coverage -instr-profile=code_coverage.profdata

#llvm-cov show -show-line-counts-or-regions ./code_coverage -instr-profile=code_coverage.profdata

llvm-cov show -show-line-counts-or-regions --show-regions=1 --show-expansions ./code_coverage -instr-profile=code_coverage.profdata

llvm-cov report ./code_coverage -instr-profile=code_coverage.profdata
