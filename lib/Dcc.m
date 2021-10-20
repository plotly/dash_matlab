function dccComponent = Dcc(method, properties)
% Dcc Constructs a dash_core_components component for dash
%
%  Dcc(method, properties)
%
%  method: string.
%  properties: cell array containing name-value pairs with properties.
%
%  For example, a dash_core_components.Graph(figure=figure) would be
%  done like:
%
%  Dcc('Graph', {'figure', figure})
    if strcmp(method, 'Graph')
        try
            plotlyfig = py.dict(pyargs('data',properties{2}.data,'layout',properties{2}.layout));
        catch
            plotlyfig = py.dict(pyargs('data',py.list(),'layout',py.dict()));
        end
        dccComponent = py.dash_core_components.Graph(pyargs('figure', plotlyfig, 'id', properties{2}));
    else
        %a = char(jsonencode(properties));
        %b = py.json.loads(a);
        %c = cell(b);    
        dccComponent = py.dash_core_components.(method)(pyargs(properties{:}));
    end
end
