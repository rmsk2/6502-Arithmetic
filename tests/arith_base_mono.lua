require(test_dir .. "conv")

function arrange()
    set_memory(load_address+3, txt_to_mem(valL))
end

function assert()
    op_res = mem_to_text(get_memory(load_address+3, 5))
    res = (string.lower(op_res) == string.lower(opRes))
    err_msg = ""

    if not res then
        err_msg = "Wrong result: " .. op_res .. ". Expected " .. opRes 
    end

    return res, err_msg
end