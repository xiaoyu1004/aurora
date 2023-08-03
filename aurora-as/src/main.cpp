#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>

int get_reg_idx(std::string reg_name) {
    std::string idx = reg_name.substr(1);
    int reg_idx     = std::stoi(idx);
    if (reg_idx < 0 || reg_idx >= 32) {
        printf("invalid reg idx range! reg_name: %s\n", reg_name.c_str());
        exit(-1);
    }
    return reg_idx;
}

int main(int argc, const char* argv[]) {
    if (argc < 2) {
        printf("useage: ./aurora-as asm_file\n");
        exit(-1);
    }

    std::ifstream fs(argv[1]);
    if (!fs.is_open()) {
        printf("open file failed\n");
        exit(-1);
    }

    std::string line;
    while (std::getline(fs, line)) {
        if (line.find("#") == 0 || line == "\0") {
            continue;
        }

        int instr_name_end_idx = line.find(" ");
        std::string instr_name = line.substr(0, instr_name_end_idx);
        std::string instr_rest = line.substr(instr_name_end_idx + 1);

        std::string instr_removed_space;
        for (int i = 0; i < instr_rest.size(); ++i) {
            if (!isspace(instr_rest.at(i))) {
                instr_removed_space.append(1, instr_rest.at(i));
            }
        }

        int comma_idx_0     = instr_removed_space.find(",");
        int comma_idx_1     = instr_removed_space.find(",", comma_idx_0 + 1);
        // rd, r1, r2
        std::string wr_name = instr_removed_space.substr(0, comma_idx_0);
        std::string r1_name =
            instr_removed_space.substr(comma_idx_0 + 1, comma_idx_1 - comma_idx_0 - 1);
        std::string r2_name = instr_removed_space.substr(comma_idx_1 + 1);

        uint32_t instr_bin = 0;

        if (instr_name == "xor") {
            // std::cout << "xor" << std::endl;

            // opcode
            instr_bin |= 0b0110011;
            // funct3
            instr_bin |= (0b100 << 12);
            // funct7
            instr_bin |= (0b0000000 << 25);

            int wr_idx = get_reg_idx(wr_name);
            int r1_idx = get_reg_idx(r1_name);
            int r2_idx = get_reg_idx(r2_name);

            // rR1
            instr_bin |= (r1_idx << 15);
            // rR2
            instr_bin |= (r2_idx << 20);
            // wR
            instr_bin |= (wr_idx << 7);

            // std::cout << instr_removed_space << " ==== " << wr_idx << "; " << r1_idx << "; "
            //           << r2_idx << std::endl;
        } else if (instr_name == "addi") {
            // std::cout << "addi" << std::endl;

            // opcode
            instr_bin |= 0b0010011;
            // funct3
            instr_bin |= (0b000 << 12);
            // imm_i
            int imm_i = std::stoi(r2_name);
            instr_bin |= (imm_i << 20);

            int wr_idx = get_reg_idx(wr_name);
            int r1_idx = get_reg_idx(r1_name);

            // rR1
            instr_bin |= (r1_idx << 15);
            // wR
            instr_bin |= (wr_idx << 7);
        } else if (instr_name == "add") {
            // std::cout << "add" << std::endl;

            // opcode
            instr_bin |= 0b0110011;
            // funct3
            instr_bin |= (0b000 << 12);
            // funct7
            instr_bin |= (0b0000000 << 25);

            int wr_idx = get_reg_idx(wr_name);
            int r1_idx = get_reg_idx(r1_name);
            int r2_idx = get_reg_idx(r2_name);

            // rR1
            instr_bin |= (r1_idx << 15);
            // rR2
            instr_bin |= (r2_idx << 20);
            // wR
            instr_bin |= (wr_idx << 7);
        } else {
            std::cout << "invalid instr: " << line << std::endl;
            return -1;
        }

        std::cout << std::hex << "0x" << std::setw(8) << std::setfill('0') << instr_bin
                  << std::endl;
    }

    fs.close();
    return 0;
}