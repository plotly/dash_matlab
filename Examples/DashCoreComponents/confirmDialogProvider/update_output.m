function outTxt = update_output(submit_n_clicks)
    if ~strcmp(string(submit_n_clicks), 'NaN')
        outTxt = sprintf(['It was dangerous but we did it!\n',...
            'Submitted %d times'], submit_n_clicks);
    else
        outTxt = '';
    end
    outTxt = jsonencode({outTxt});
end

