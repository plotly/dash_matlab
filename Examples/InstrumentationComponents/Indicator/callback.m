function val = callback(value)
    if rem(value, 2) == 0
        val = true;
    else
        val = false;
    end
    val = jsonencode(val);
end
