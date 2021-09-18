function fig = plotlyfig2dash(plotlyfig, id)
    
    if iscategorical(plotlyfig.data{1}.x)
        plotlyfig.layout.xaxis1.('ticktext') = cellstr(plotlyfig.data{1}.x);
        for i=1:numel(plotlyfig.data)
            plotlyfig.data{i}.x = 1:1:numel(plotlyfig.data{i}.x);
        end
        plotlyfig.layout.xaxis1.('tickmode') = 'array';
        plotlyfig.layout.xaxis1.('tickvals') = 1:1:numel(plotlyfig.data{1}.x);
        plotlyfig.layout.xaxis1.autorange = 1;
        plotlyfig.layout.yaxis1.autorange = 1;

        plotlyfig.layout.showlegend = 1;
        plotlyfig.layout.('legend') = struct(...
            'font', struct('color', '#7f7f7f'),...
            'y', 0.5, 'x', 1);  

    end
    
    try
        if plotlyfig.layout.barmode == 'group'
            plotlyfig.layout.bargap = 0.2;
            plotlyfig.layout.bargroupgap = 0;
        end
    end
    
    plotlyfig = py.dict(pyargs('data',plotlyfig.data,'layout',plotlyfig.layout));
    
    fig = py.dash_core_components.Loading(pyargs('id', string(id)+'loading',...
        'children',{py.dash_core_components.Graph(pyargs('id', id, 'figure', plotlyfig))},...
        'type','circle'));
end
