#include <iostream>
#include <string>

enum Token { Ident, Assign };

bool is_alphabet(char c) { return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'); }

bool is_underline(char c) { return c == '_'; }

bool is_number(char c) { return c >= '0' && c <= '9'; }

struct symbol {
    std::string name;
    std::int32_t val;
    bool valid = false;
};

symbol* symbol_tables  = nullptr;
symbol* cur_symbol_ptr = nullptr;
std::int32_t num_val;

Token next(char* psrc, char** ppsrc) {
    while (true) {
        if (isspace(*psrc) || *psrc == '\n') {
            continue;
        }

        // ident
        if (is_alphabet(*psrc) || is_underline(*psrc)) {
            char* start = psrc;
            int n       = 0;
            while (is_alphabet(*psrc) || is_underline(*psrc) || is_number(*psrc)) {
                ++n;
                ++psrc;
            }
            *ppsrc = psrc;
            std::string ident_name = std::string(start, n);
            // find symbol table
            cur_symbol_ptr = symbol_tables;
            while (cur_symbol_ptr->valid) {
                if (cur_symbol_ptr->name == ident_name) {
                    return Ident;
                }
                ++cur_symbol_ptr;
            }
            // find miss
            cur_symbol_ptr->name  = ident_name;
            cur_symbol_ptr->valid = true;
            return Ident;
        }

        // assign
        if ()
    }
}

int main(int argc, const char* argv[]) {
    std::cout << "hello aurora-cc" << std::endl;

    symbol_tables = new symbol[1024];

    delete[] symbol_tables;

    return 0;
}