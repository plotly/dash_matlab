function val = callback(on)
    msg = sprintf('The switch is %s', string(on));
    val = jsonencode(msg);
end
