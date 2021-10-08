function out = update_output(value)
    if strcmp(value, "NaN")
        out = jsonencode({sprintf('No data.')});
    else
        out = jsonencode({string(value)});
    end
end
