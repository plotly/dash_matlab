function out = update_output(value)
    out = sprintf('You have selected "{%s, %s}"',...
        string(value{1}), string(value{2}));
    out = jsonencode({out});
end
