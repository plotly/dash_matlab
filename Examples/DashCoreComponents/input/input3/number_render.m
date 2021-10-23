function out = number_render(fval, tval, rangeval)
    out = sprintf('dfalse: %s, dtrue: %s, range: %s',...
        string(fval), string(tval), string(rangeval));
    out = jsonencode({out});
end

