function htmlComponent = Html(method, properties)
    a = char(jsonencode(properties));
    b = py.json.loads(a);
    c = cell(b);
    htmlComponent = py.dash_html_components.(method)(pyargs(c{:}));
end
