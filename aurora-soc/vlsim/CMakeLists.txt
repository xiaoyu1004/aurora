file(GLOB_RECURSE rtl_srcs ${PROJECT_SOURCE_DIR}/aurora-soc/cpu/rtl/*.v
                        ${PROJECT_SOURCE_DIR}/aurora-soc/top/lib/*.v
                        ${PROJECT_SOURCE_DIR}/aurora-soc/top/rtl/*.v)
set(obj_dir "${PROJECT_BINARY_DIR}/vlsim")
set(cpmile_rtl_cmd verilator --cc --trace --exe --build --top-module top ${rtl_srcs} ${PROJECT_SOURCE_DIR}/aurora-soc/sim/top_test.cpp -I${PROJECT_SOURCE_DIR}/aurora-soc/cpu/include -I${PROJECT_SOURCE_DIR}/aurora-soc/top/include)
add_custom_command(OUTPUT ${obj_dir} COMMAND ${cpmile_rtl_cmd})
add_custom_target(RTL_TO_CPP ALL DEPENDS ${obj_dir})