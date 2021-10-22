function msgDiv = update_output(value)
    msg = sprintf('You have selected %s', value);
    msgDiv = jsonencode({msg});
end
