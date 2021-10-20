function outDiv = render_content(tab)
    if strcmp(tab, 'tab-1')        
        H3 = Html('H3', {'Tab content 1'});
    elseif strcmp(tab, 'tab-2')
        H3 = Html('H3', {'Tab content 2'});
    end
    outDiv = Html('Div', {H3});
    outDiv = plotlyJsonEncoder(outDiv);
end

