cmake_minimum_required(VERSION 3.22.1)
project(SNURISCVProject)

# Set Xilinx Vivado installation path
set(VIVADO_PATH "/home/evan/vivado2022.2/Vivado/2022.2")
set(TESTBENCH   "tb_snuriscv")
set(XILINX_OUTPUT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/build)
set(CACHE SYNTHESIS  false)
set(CACHE DEBUG_MODE true)

# Set project source files
set(XILINX_DEFINE)
set(SOURCES
    # Common
    ${XILINX_OUTPUT_PATH}/../rtl/common/definitions.vh 
    ${XILINX_OUTPUT_PATH}/../rtl/common/clock_gating_module.v 

    # Control
    ${XILINX_OUTPUT_PATH}/../rtl/soc/control/control_logic.v 

    # Datapath
    ${XILINX_OUTPUT_PATH}/../rtl/soc/datapath/opcode_decoder.v 
    ${XILINX_OUTPUT_PATH}/../rtl/soc/datapath/pcgen.v 
    ${XILINX_OUTPUT_PATH}/../rtl/soc/datapath/alu.v 


    # SoC
    ${XILINX_OUTPUT_PATH}/../rtl/soc/dcache.v 
    ${XILINX_OUTPUT_PATH}/../rtl/soc/icache.v 
    ${XILINX_OUTPUT_PATH}/../rtl/soc/frontend.v 
    ${XILINX_OUTPUT_PATH}/../rtl/soc/snurisc_core.v 

    # Others
    ${XILINX_OUTPUT_PATH}/../rtl/snurisc_top.v
    ${XILINX_OUTPUT_PATH}/../testbench/${TESTBENCH}.v
) 

if (DEBUG_MODE)
    message("DEBUG_MODE")
    set(XILINX_DEFINE ${XILINX_DEFINE} -d CONFIGURE_DEBUG)
    set(XILINX_DEFINE ${XILINX_DEFINE} -d CONFIGURE_DEBUG_FRONTEND)
endif()

if (SYNTHESIS)
    include(cmake/synthesis.cmake)
    set(XILINX_DEFINE ${XILINX_DEFINE} -d CONFIGURE_SYNTHESIS)
else()
    include(cmake/simulation.cmake)
endif()

