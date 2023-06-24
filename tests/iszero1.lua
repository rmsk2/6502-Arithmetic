require(test_dir .. "mono_test")

test_data = {    
    [1] = {valL = "-00000000", refVal = true},
    [2] = {valL = "+00000000", refVal = true},
    [3] = {valL = "+00000001", refVal = false},
    [4] = {valL = "+01000000", refVal = false}
}
