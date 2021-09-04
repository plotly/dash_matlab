function out = callback_a(x)
    out = char(jsonencode({x^2, x^3, 2^x, 3^x, x^x}));
end

