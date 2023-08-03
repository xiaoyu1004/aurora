file(GLOB_RECURSE srcs ${PROJECT_SOURCE_DIR}/aurora-emu/src/*.cpp ${PROJECT_SOURCE_DIR}/aurora-emu/src/*.h)
add_executable(aurora-emu ${srcs})