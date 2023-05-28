# Set project constraints
set(CONSTRAINTS
    constraints/clock_constraints.xdc
    constraints/pin_constraints.xdc
    # Add more constraint files here
)

# Vivado synthesis
add_custom_target(synthesis
    COMMAND ${VIVADO_PATH}/bin/vivado -mode batch -source synthesis.tcl
    DEPENDS ${SOURCES} ${CONSTRAINTS}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)

# Vivado implementation
add_custom_target(implementation
    COMMAND ${VIVADO_PATH}/bin/vivado -mode batch -source implementation.tcl
    DEPENDS synthesis
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)

# Vivado bitstream generation
add_custom_target(bitstream
    COMMAND ${VIVADO_PATH}/bin/vivado -mode batch -source bitstream.tcl
    DEPENDS implementation
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)

# Add top-level targets
add_custom_target(synthesize DEPENDS synthesis)
add_custom_target(implement  DEPENDS implementation)
add_custom_target(generate_bitstream DEPENDS bitstream)