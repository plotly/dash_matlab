function out = func(n_clicks)
    d = struct('content', 'Hello world!',...
        'filename', 'hello.txt');
    out = jsonencode({d});
end

