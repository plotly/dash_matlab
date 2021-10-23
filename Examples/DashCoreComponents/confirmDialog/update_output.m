function outTxt = update_output(submit_n_clicks)
    if ~strcmp(string(submit_n_clicks), 'NaN')
        outTxt = sprintf('It wasnt easy but we did it %d', submit_n_clicks);
    else
        outTxt = '';
    end
    outTxt = jsonencode({outTxt});
end

