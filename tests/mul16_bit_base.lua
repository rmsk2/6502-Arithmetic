
function arrange()
    set_accu(val1)
    set_xreg(val2)
end

function assert()
    result = 256 * get_accu() + get_xreg()
    error_msg = ""

    res = (result == (val1*val2))

    if not res then
        error_msg = string.format("Wrong result: %d", result)
    end

    return res, error_msg
end