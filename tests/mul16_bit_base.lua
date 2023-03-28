test_data = {
    [1] = {val1 = 35, val2 = 2},
    [2] = {val1 = 255, val2 = 255},
    [3] = {val1 = 0, val2 = 255},
    [4] = {val1 = 173, val2 = 255},
    [5] = {val1 = 1, val2 = 183}    
}

function num_iterations() 
    return #test_data
end

iter_count = 0

function arrange()
    iter_count = iter_count + 1
    set_pc(load_address)
    set_accu(test_data[iter_count].val1)
    set_xreg(test_data[iter_count].val2)
end

function assert()
    in1 = test_data[iter_count].val1
    in2 = test_data[iter_count].val2
    res = (get_accu() * 256) + get_xreg()

    return res == in1 * in2, string.format("Unexpected value: %d * %d is not %d", in1, in2, res)
end