function txt_to_mem(val) 
    sign = string.sub(val, 1, 1)
    b1 = string.sub(val, 2, 3)
    b2 = string.sub(val, 4, 5)
    b3 = string.sub(val, 6, 7)
    b4 = string.sub(val, 8, 9)

    sign_byte = "00"
    if sign == "-" then
        sign_byte = "01"
    end

    return sign_byte .. b4 .. b3 .. b2 .. b1
end

function mem_to_text(val) 
    sign_byte = string.sub(val, 1, 2)
    b1 = string.sub(val, 3, 4)
    b2 = string.sub(val, 5, 6)
    b3 = string.sub(val, 7, 8)
    b4 = string.sub(val, 9, 10)

    sign = "+"
    if sign_byte == "01" then
        sign = "-"
    end

    return sign .. b4 .. b3 .. b2 .. b1
end

function contains_flag(f)
    return string.find(get_flags(), f, 0, true) ~= nil
end