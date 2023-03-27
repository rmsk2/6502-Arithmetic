require(test_dir .. "conv")

test_data = {
    [1] = {valL="-FFDDEEAA", valR="+AAEEDDFF", refValZero=false, refValCarry=false},
    [2] = {valL="+00000000", valR="-AAEEDDFF", refValZero=false, refValCarry=true},
    [3] = {valL="+00000000", valR="+AAEEDDFF", refValZero=false, refValCarry=false},
    [4] = {valL="-00000430", valR="-00000005", refValZero=false, refValCarry=false},
    [5] = {valL="-00000001", valR="-AAEEDDFF", refValZero=false, refValCarry=true},
    [6] = {valL="+00000000", valR="-00000000", refValZero=true, refValCarry=true},
    [7] = {valL="+07000000", valR="+07000000", refValZero=true, refValCarry=true}
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
    res1 = contains_flag("Z") == test_data[test_count].refValZero 
    res2 = contains_flag("C") == test_data[test_count].refValCarry 
    res = res1 and res2

    if not res then
        err_msg = "Incorrect flag vlues: " .. get_flags()
    end

    return res, err_msg
end