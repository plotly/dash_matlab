function msgDiv = update_output(value)
    msg = sprintf('You have entered: \n%s', value);
    msgDiv = jsonencode({msg});
end
