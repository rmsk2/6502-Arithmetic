test_data = {
    [1] = {val1 = 35, val2 = 2},
    [2] = {val1 = 255, val2 = 255},
    [3] = {val1 = 0, val2 = 255},
    [4] = {val1 = 173, val2 = 12},
    [5] = {val1 = 12, val2 = 173},
    [6] = {val1 = 173, val2 = 255},
    [7] = {val1 = 1, val2 = 183},
    [8] = {val1 = 64, val2 = 32},
    [9] = {val1 = 122, val2 = 10},
    [10] = {val1 = 122, val2 = 122},
    [11] = {val1 = 183, val2 = 1},
    [12] = {val1 = 27, val2 = 9},
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

    correct_mod = in1 % in2
    res_mod = (get_xreg() == correct_mod)
    if not res_mod then
        return false, string.format("Unexpected value: %d mod %d is not %d (should be %d)", in1, in2, get_xreg(), correct_mod)
    end

    correct_div = math.floor(in1 / in2)
    res_div = (get_accu() == correct_div)
    if not res_div then
        return false, string.format("Unexpected value: %d div %d is not %d (should be %d)", in1, in2, get_accu(), correct_div)
    end

    return true, "All OK"
end