function bioComponent = dashBio(method, properties)
    try
        bioComponent = py.dash_bio.(method)(pyargs(properties{:}));
    catch
        a = char(jsonencode(properties));
        b = py.json.loads(a);
        c = cell(b);
        bioComponent = py.dash_bio.(method)(pyargs(c{:}));
    end
end