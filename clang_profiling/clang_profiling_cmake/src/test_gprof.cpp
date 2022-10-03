#include <iostream>
#include "test_gprof.h"
#include "test_gprof_new.h"

void func1()
{
    std::cout << "Inside func1" << std::endl;
    uint32_t b = 0;

    for(uint32_t i = 0; i < static_cast<uint32_t>(((static_cast<uint64_t>(1) << 32) - static_cast<uint64_t>(1)));i++)
    {
        b++;
    }

    std::cout << "b: " << b << std::endl;
    new_func1();

    return;
}

void func2()
{
    std::cout << "Inside func2" << std::endl;
    uint32_t c = 0;

    for(uint32_t i = 0; i < static_cast<uint32_t>(((static_cast<uint64_t>(1) << 32) - static_cast<uint64_t>(1)));i++)
    {
        c++;
    }

    std::cout << "c: " << c << std::endl;
}
