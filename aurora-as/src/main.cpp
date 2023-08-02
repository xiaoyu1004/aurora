#include <iostream>
#include <fstream>

int main(int argc, const char *argv[]) {
    if (argc < 2) {
        printf("useage: ./aurora-as asm_file\n");
        exit(-1);
    }

    std::ifstream fs(argv[1]);
    if (!fs.is_open()) {
        printf("open file failed\n");
        exit(-1);
    }

    std::cout << "hello aurora-as" << std::endl;
    return 0;
}