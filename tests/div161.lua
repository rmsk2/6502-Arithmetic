test_data = {
    [1] = {val1 = 173, val2 = 12},
    [2] = {val1 = 35, val2 = 2},
    [3] = {val1 = 255, val2 = 255},
    [4] = {val1 = 0, val2 = 255},    
    [5] = {val1 = 12, val2 = 173},
    [6] = {val1 = 173, val2 = 255},
    [7] = {val1 = 1, val2 = 183},
    [8] = {val1 = 64, val2 = 32},
    [9] = {val1 = 122, val2 = 10},
    [10] = {val1 = 122, val2 = 122},
    [11] = {val1 = 183, val2 = 1},
    [12] = {val1 = 27, val2 = 9},
    [13] = {val1 = 17534, val2 = 368},
    [14] = {val1 = 320, val2 = 8},
    [15] = {val1 = 24813, val2 = 48193},
    [16] = {val1 = 48193, val2 = 24813},
    [17] = {val1 = 10000, val2 = 2},
    [18] = {val1 = 257, val2 = 10000},
    [19] = {val1 = 53221, val2 = 256},
    [20] = {val1 = 53221, val2 = 255},
    [21] = {val1 = 65535, val2 = 65535},
    [22] = {val1 = 65535, val2 = 12491},
    [23] = {val1 = 10000, val2 = 257},
    [24] = {val1 = 32768, val2 = 8192},
}

function num_iterations() 
    return #test_data
end

iter_count = 0

function set_word(val, addr)
    hi = math.floor(val / 256)
    lo = val % 256
    write_byte(addr+1, hi)
    write_byte(addr, lo)
end

function get_word(addr)
    return read_byte(addr+1) * 256 + read_byte(addr)
end

function arrange()
    iter_count = iter_count + 1
    set_pc(load_address)
    set_word(test_data[iter_count].val1, load_address + 5)
    set_word(test_data[iter_count].val2, load_address + 3)
end

function assert()
    in1 = test_data[iter_count].val1
    in2 = test_data[iter_count].val2
    
    calc_mod = get_word(load_address + 9)
    calc_div = get_word(load_address + 7)

    correct_mod = in1 % in2
    res_mod = ( calc_mod == correct_mod)
    if not res_mod then
        return false, string.format("Unexpected value: %d mod %d is not %d (should be %d)", in1, in2, calc_mod, correct_mod)
    end

    correct_div = math.floor(in1 / in2)    
    res_div = (calc_div == correct_div)
    if not res_div then
        return false, string.format("Unexpected value: %d div %d is not %d (should be %d)", in1, in2, calc_div, correct_div)
    end

    return true, "All OK"
end