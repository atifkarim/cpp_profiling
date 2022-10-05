rm -rf bin/ build/ lib/
mkdir build
cd build
cmake ..
# cmake .. -DCMAKE_CXX_FLAGS=-pg -DCMAKE_EXE_LINKER_FLAGS=-pg -DCMAKE_SHARED_LINKER_FLAGS=-pg
make
cd ../bin

# creation of profraw file by executing the executable binary
LLVM_PROFILE_FILE="clang_prof_exec.profraw" ./clang_prof_exec

# Creation of profile data
llvm-profdata merge -sparse clang_prof_exec.profraw -o clang_prof_exec.profdata

# following commands are needed to investigate profiling output. Use any of these
# llvm-cov show ./clang_prof_exec -instr-profile=clang_prof_exec.profdata
llvm-cov report ./clang_prof_exec -instr-profile=clang_prof_exec.profdata

# gprof profiling tool for making analysis file
# This portion should be executed if one time the executable is run which has already done
# in "LLVM_PROFILE_FILE="clang_prof_exec.profraw" ./clang_prof_exec"
# Actually, it requires only perform of : ./clang_prof_exec

gprof clang_prof_exec gmon.out > analysis.txt
