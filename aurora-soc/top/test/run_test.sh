iverilog                 \
    -o top_tb.out        \
    -s top_tb            \
    -I ../include        \
    -I ../../cpu/include \
    -y ../lib            \
    ./top_tb.v           \
    ../rtl/*.v           \
    ../../cpu/rtl/*.v    \

