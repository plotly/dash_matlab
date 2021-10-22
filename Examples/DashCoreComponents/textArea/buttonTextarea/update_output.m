function msgDiv = update_output(n_clicks, value)
    if n_clicks > 0
        msg = sprintf('You have entered: \n%s', value);        
    else
        msg = '';  
    end
    msgDiv = jsonencode({msg});
end
