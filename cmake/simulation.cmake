# Vivado Simnulation
message("${VIVADO_PATH}/bin/xvlog ${SOURCES}")
add_custom_target(xvlog
    COMMAND ${VIVADO_PATH}/bin/xvlog ${SOURCES}
    DEPENDS ${SOURCES} ${CONSTRAINTS}
    WORKING_DIRECTORY ${XILINX_OUTPUT_PATH}
)

message("${VIVADO_PATH}/bin/xelab ${TESTBENCH} -debug wave -s ${TESTBENCH}")
add_custom_target(xelab
    COMMAND ${VIVADO_PATH}/bin/xelab ${TESTBENCH} -debug wave -s ${TESTBENCH}
    DEPENDS ${SOURCES} ${CONSTRAINTS} xvlog
    WORKING_DIRECTORY ${XILINX_OUTPUT_PATH}
)

message("${VIVADO_PATH}/bin/xvlog ${TESTBENCH} -gui -wdb simulate_xsim_${TESTBENCH}.wdb")
add_custom_target(xsim
    COMMAND ${VIVADO_PATH}/bin/xsim ${TESTBENCH} -gui -wdb simulate_xsim_${TESTBENCH}.wdb
    DEPENDS ${SOURCES} ${CONSTRAINTS} xelab
    WORKING_DIRECTORY ${XILINX_OUTPUT_PATH}
)    

# Sim-Clean
add_custom_target(sim-clean
    COMMAND  rm -rf *xe* *xs* *.wdb* *trace* *xv* *we* .hbs .Xil
    WORKING_DIRECTORY ${XILINX_OUTPUT_PATH}
)