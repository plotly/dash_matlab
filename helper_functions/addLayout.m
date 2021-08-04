function layout = addLayout(varargin)

    % disp(varargin);
    % create an empty DIV to put all of the components inside
    
    layout = py.dash_html_components.Div({});
    
    layout.children = varargin;
end