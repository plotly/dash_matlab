function fig = plotlyfig2dash(plotlyfig, id)
    plotlyfig.layout.showlegend = 1;
    plotlyfig.layout.('legend') = struct(...
        'font', struct('color', '#000000'),...
        'y', 0.5, 'x', 1);

    plotlyfig1 = struct('data', {plotlyfig.('data')}, 'layout', plotlyfig.('layout'));
    a = char(jsonencode(plotlyfig1));
    plotlyfig = py.json.loads(a);

    %plotlyfig = py.dict(pyargs('data',{},'layout',struct()));
    
    fig = py.dash.dcc.Loading(pyargs('id', string(id)+'loading',...
        'children',{py.dash.dcc.Graph(pyargs('id', id, 'figure', plotlyfig))},...
        'type','circle'));
end
