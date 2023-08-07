iverilog -o top_tb.out  \
        -s top_tb  \
        -I ../top/include  \
        -I ../cpu/include \
        -y ../top/lib   \
        ../top/test/top_tb.v \
        ../top/rtl/*.v \
        ../cpu/rtl/*.v \
        ../top/lib/*.v

vvp top_tb.out