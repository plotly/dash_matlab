function output = update_output(input1, input2)
    output = jsonencode({sprintf(...
        'Input 1 is "%s" and Input 2 is "%s"', input1, input2)});
end

