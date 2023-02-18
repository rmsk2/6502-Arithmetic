require(test_dir .. "conv")

function arrange()
    set_memory(load_address+3, txt_to_mem(valL))
    set_memory(load_address+8, txt_to_mem(valR))
end

function assert()
    err_msg = ""
    res1 = contains_flag("Z") == refValZero 
    res2 = contains_flag("C") == refValCarry 
    res = res1 and res2

    if not res then
        err_msg = "Incorrect flag vlues: " .. get_flags()
    end

    return res, err_msg
end