function dccComponent = Dcc(method, properties)
    if strcmp(method, 'Graph')
        try
            plotlyfig = py.dict(pyargs('data',properties{2}.data,'layout',properties{2}.layout));
        catch
            plotlyfig = py.dict(pyargs('data',py.list(),'layout',py.dict()));
        end
        dccComponent = py.dash_core_components.Graph(pyargs('figure', plotlyfig, 'id', properties{2}));
    else
        a = char(jsonencode(properties));
        b = py.json.loads(a);
        c = cell(b);    
        dccComponent = py.dash_core_components.(method)(pyargs(c{:}));
    end
end
