function outTxt = callback(input_value)
    msg = sprintf('Output: %s', input_value);
    outTxt = jsonencode(msg);

end
