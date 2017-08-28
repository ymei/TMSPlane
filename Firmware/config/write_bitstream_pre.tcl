## Allow unconstrained IO ports
# set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
# set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
# For unused but constrained LVDS pins
set_property SEVERITY {Warning} [get_drc_checks IOSTDTYPE-1]
