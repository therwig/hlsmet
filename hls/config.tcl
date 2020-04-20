### Define which function to use
set l1metAlgo "met_hw"

# MET implementation, with MP7 data wrapper around it
set l1metTopFunc ${l1metAlgo}

# reference (non-wrapped) MET implementation
set l1metRefFunc "met_ref"

# set to zero to turn off C validation (runs but does not check against the reference implementation)
set l1metValidate 1

## version of the IP Core output
set l1metIPVersion 1.0
