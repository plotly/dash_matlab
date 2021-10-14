function outTxt = update_output_div(input_value)
    outTxt = jsonencode({sprintf('Output: %s', input_value)});
end
