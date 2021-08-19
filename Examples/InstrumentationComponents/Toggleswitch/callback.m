function val = callback(value)
    msg = sprintf('The switch is %s', string(value));
    val = jsonencode(msg);
end
