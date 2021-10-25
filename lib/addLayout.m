function layout = addLayout(varargin)

    % disp(varargin);
    % create an empty DIV to put all of the components inside
    
    layout = py.dash.html.Div(pyargs('className', "dash-bootstrap"));
    
    layout.children = varargin;
    
end