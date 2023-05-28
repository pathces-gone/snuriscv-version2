cmake_minimum_required(VERSION 3.22.1)
project(SNURISCVProject)

# Set Xilinx Vivado installation path
set(VIVADO_PATH "/home/evan/vivado2022.2/Vivado/2022.2")
set(TESTBENCH   "tb_snuriscv")
set(XILINX_OUTPUT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/build)

# Set project source files
set(SOURCES
    # Common
    ${XILINX_OUTPUT_PATH}/../rtl/common/clock_gating_module.v 

    # Control

    # Datapath
    ${XILINX_OUTPUT_PATH}/../rtl/datapath/alu.v 

    # Others
    ${XILINX_OUTPUT_PATH}/../rtl/snuriscv.v
    ${XILINX_OUTPUT_PATH}/../testbench/${TESTBENCH}.v
) 

if (SYNTHESIS)
    include(cmake/synthesis.cmake)
else()
    include(cmake/simulation.cmake)
endif()