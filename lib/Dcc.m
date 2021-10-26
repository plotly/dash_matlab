function dccComponent = Dcc(varargin)
% Dcc Constructs a dash_core_components component for dash
%
%  Dcc(method, properties)
%
%  method: string.
%  properties: cell array containing name-value pairs with properties.
%
%  For example, a dash_core_components.Graph(figure=figure) 
%  would be done like:
%
%  Dcc('Graph', {'figure', figure})
%
%  The 'children' can be set implicitly, but it has to be the first
%  argument to be render properly.
%  For example, this expressions are equivalent:
%
%  Dcc('Tabs', {'children',{Dcc('Tab', {'label','one','value','tab1'})}})
%  Dcc('Tabs', {{Dcc('Tab', {'label','one','value','tab1'})}})

    method = varargin{1};
    properties = varargin{2}; % Name value pairs.
    if strcmp(method, 'Graph')
        try
            plotlyfig = py.dict(pyargs('data',properties{2}.data,'layout',properties{2}.layout));
        catch
            plotlyfig = py.dict(pyargs('data',py.list(),'layout',py.dict()));
        end
        dccComponent = py.dash.dcc.Graph(pyargs('figure', plotlyfig, 'id', properties{2}));
    else
        % If the number of properties is odd,
        % make the first one the children        
        if mod(length(properties),2)
            properties = ['children', properties];
        end           
        dccComponent = py.dash.dcc.(method)(pyargs(properties{:}));
    end
end
