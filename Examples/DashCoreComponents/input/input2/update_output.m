function out = update_output(input1, input2)
    out = sprintf('Input 1 %s and Input 2 %s', string(input1), string(input2));
    out = jsonencode({out});
end
