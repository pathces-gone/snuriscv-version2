cmake_minimum_required(VERSION 3.22.1)
project(SNURISCVProject)

# Set Xilinx Vivado installation path
set(VIVADO_PATH "/home/evan/vivado2022.2/Vivado/2022.2")
set(TESTBENCH   "tb_snuriscv")
set(XILINX_OUTPUT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/build)

# Set project source files
set(SOURCES
    ${XILINX_OUTPUT_PATH}/../rtl/clock_gating_model.v 
    ${XILINX_OUTPUT_PATH}/../testbench/${TESTBENCH}.v
) 

if (SYNTHESIS)
    include(cmake/synthesis.cmake)
else()
    include(cmake/simulation.cmake)
endif()