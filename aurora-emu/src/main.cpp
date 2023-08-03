#include "cpu.h"

#include <iostream>

int main(int argc, const char** argv) {

    std::uint32_t dumy_inst[] = {
        0x00a54533, 0x00250513, 0x00b5c5b3, 0x00358593, 0x00b50533, 0xfff50513, 0xffd50513};

    rvemu::cpu cpu;
    cpu.load_inst(reinterpret_cast<uint8_t*>(dumy_inst), sizeof(dumy_inst));
    cpu.start();

    return 0;
}