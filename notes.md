1. add county model


## Flow!
1. call two API end points (states_info, states_current)
1. make hashes of states_info and states_current
1. combine the two hashes on the primary key of "state" which is the two letter capitalized abbreviation of the state
1. use those combined hashes to create State instances