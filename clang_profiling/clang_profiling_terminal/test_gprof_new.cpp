//test_gprof_new.c
#include <iostream>

void new_func1()
{
    std::cout << "Inside new_func1()" << std::endl;
    uint32_t a = 0;

    for(uint32_t i = 0; i < static_cast<uint32_t>(((static_cast<uint64_t>(1) << 32) - static_cast<uint64_t>(1)));i++)
    {
        a++;
    }

    std::cout << "a: " << a << std::endl;
    return;
}

