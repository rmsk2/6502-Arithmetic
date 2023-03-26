function arrange()
    set_memory(load_address+3, "01FFFFFFFF")
end

function assert()
    clr = get_memory(load_address+3, 5)

    if clr == "0000000000" then
        return true, ""
    end

    return false, string.format("Unexpected memory contents: %s", clr)
end