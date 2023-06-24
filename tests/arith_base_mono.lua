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
    op_res = mem_to_text(get_memory(load_address+3, 5))
    res = (string.lower(op_res) == string.lower(test_data[iter_count].opRes))
    err_msg = ""

    if not res then
        err_msg = "Wrong result: " .. op_res .. ". Expected " .. opRes 
    end

    return res, err_msg
end