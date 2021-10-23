function out = display_confirm(value)
    if strcmp(value, 'Danger!!')
        out = true;
    else
        out = false;
    end
    out = jsonencode({out});
end

