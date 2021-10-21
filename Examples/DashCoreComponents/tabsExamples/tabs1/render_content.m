function outDiv = render_content(tab)
    figure('visible', 'off');
    if strcmp(tab, 'tab-1-example-graph')        
        bar([1 2 3], [3 1 2]);
        H3 = Html('H3', {'Tab content 1'});
    elseif strcmp(tab, 'tab-2-example-graph')
        bar([1 2 3], [5 10 6]);
        H3 = Html('H3', {'Tab content 2'});
    end
    
    fig = fig2plotly(gcf, 'offline', true, 'open', false, 'Visible', false);
    addtheme(fig, 'plotly_dark');
    myFig = Html('Center', {plotlyfig2dash(fig, 'my-fig')});
    
    myDiv = Html('Div', {{H3, myFig}});
    
    outDiv = plotlyJsonEncoder(myDiv);
end

