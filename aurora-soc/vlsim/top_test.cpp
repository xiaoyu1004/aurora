#include "Vtop.h"

#include <verilated_vcd_c.h>

// vtopint64_t sim_time = 0;

int main(int argc, char** argv) {
    Vtop* top = new Vtop;

    // Simulate until $finish
    while (!Verilated::gotFinish()) {

        // Evaluate model
        top->eval();
    }

    // Final model cleanup
    top->final();

    // Destroy model
    delete top;

    // Return good completion status
    return 0;
}