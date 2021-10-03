function component = dashBio(method, properties)
    a = char(jsonencode(properties));
    b = py.json.loads(a);
    c = cell(b);
    component = py.dash_bio.(method)(pyargs(c{:}));
end

