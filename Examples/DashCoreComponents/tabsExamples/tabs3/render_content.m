function outDiv = render_content(tab)
    if strcmp(tab, 'tab-1')        
        H3 = Html('H3', {'Tab content 1'});
    elseif strcmp(tab, 'tab-2')
        H3 = Html('H3', {'Tab content 2'});
    elseif strcmp(tab, 'tab-3')
        H3 = Html('H3', {'Tab content 3'});
    elseif strcmp(tab, 'tab-4')
        H3 = Html('H3', {'Tab content 4'});
    end
    outDiv = Html('Div', {H3});
    outDiv = plotlyJsonEncoder(outDiv);
end
