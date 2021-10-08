function htmlComponent = Html(varargin)
    method = varargin{1};
    if nargin == 2
        properties = varargin{2};
        if length(properties) == 1
            properties = {'children', properties{1}};
        end
        a = char(jsonencode(properties));
        b = py.json.loads(a);
        c = cell(b);

        htmlComponent = py.dash_html_components.(method)(pyargs(c{:}));
    else
        htmlComponent = py.dash_html_components.(method)();
    end
end
