require(test_dir .. "conv")

iter_count = 0

function arrange()
    iter_count = iter_count + 1
    set_pc(load_address)
    set_memory(load_address+3, txt_to_mem(test_data[iter_count].valL))
end

function num_iterations() 
    return #test_data
end

function assert()
    err_msg = ""
    res = contains_flag("Z") == test_data[iter_count].refVal

    if not res then
        err_msg = "Zero flag does not have expected value"
    end

    return res, err_msg
end