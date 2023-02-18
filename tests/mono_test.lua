require(test_dir .. "conv")

function arrange()
    set_memory(load_address+3, txt_to_mem(valL))
end

function assert()
    err_msg = ""
    res = contains_flag("Z") == refVal

    if not res then
        err_msg = "Zero flag does not have expected value"
    end

    return res, err_msg
end