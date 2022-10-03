#include "test_gprof.h"
#include "test_gprof_new.h"
// #include <iostream>

int main()
{
    std::cout << "Inside main()" << std::endl;
    uint32_t d = 0;

    for(uint32_t i = 0; i < static_cast<uint32_t>(((static_cast<uint64_t>(1) << 32) - static_cast<uint64_t>(1)));i++)
    {
        d++;
    }

    std::cout << "d: " << d << std::endl;
    func1();
    func2();
    func2();

    return 0;
}
