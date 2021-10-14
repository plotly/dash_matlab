function df = update_table(page_current, page_size)
    data = readtable('https://git.io/JgqCd', 'PreserveVariableNames', true);
    data.index = (1:1:height(data))';
    data = movevars(data, 'index', 'Before', 'country');
    
    df = data(page_current*page_size+1:(page_current+1)*page_size,:);
    df = char(jsonencode({df}));
end