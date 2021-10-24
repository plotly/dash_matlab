function out = cb_render(varargin)
    out = {''};
    for val=varargin
        if ~strcmp(val, 'NaN')
            out{end+1} = string(val);
        end
    end
    out = strjoin(string(out), ' | ');
    out = jsonencode({out});
end
