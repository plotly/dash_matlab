function app = addLayout(app, varargin)

    disp(varargin);
    
    app.layout = py.dash_html_components.Div(pyargs(varargin)); % doesn't work
    
end
