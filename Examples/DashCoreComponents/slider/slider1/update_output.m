function out = update_output(value)
    out = sprintf('You have selected "%s"', string(value));
    out = jsonencode({out});
end
