require(test_dir .. "conv")

test_data = {
    [1] = {valL="-AAEEDDFF", valR="+FFDDEEAA", refVal=false},
    [2] = {valL="-00000000", valR="+00000000", refVal=true},
    [3] = {valL="-AAEEDDFF", valR="+AAEEDDFF", refVal=false},
    [4] = {valL="-AAEEDDFF", valR="-AAEEDDFF", refVal=true},
    [5] = {valL="+FFDDEEA0", valR="+FFDDEEAC", refVal=false}
}

test_count = 0

function num_iterations() 
    return #test_data
end

function arrange()
    test_count = test_count + 1
    set_pc(load_address)
    set_memory(load_address+3, txt_to_mem(test_data[test_count].valL))
    set_memory(load_address+8, txt_to_mem(test_data[test_count].valR))
end

function assert()
    err_msg = ""
    res = contains_flag("Z") == test_data[test_count].refVal 

    if not res then
        err_msg = "Zero flag does not have expected value"
    end

    return res, err_msg
end