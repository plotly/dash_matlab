function out = residue(value)
    out = char(jsonencode({struct('factor',value,...
        'animationDuration', 1000,...
        'fixedPath', false)}));
end
