function df = update_table(page_current, page_size, sort_by)
    data1 = readtable('https://git.io/JgqCd', 'PreserveVariableNames', true);

    data1.index = (1:1:height(data1))'; % Add index column
    data1.Properties.VariableNames{end} = 'Aindex';
    data2 = data1(:, sort(data1.Properties.VariableNames));
    
    if size(sort_by)
        if strcmp(sort_by{1}.direction, 'asc')
            direction = 'ascend';
        else
            direction = 'descend';
        end

        df = sortrows(data2, sort_by{1}.column_id, direction);
    else
        df = data2;
    end   

    df = df(page_current*page_size+1:(page_current+1)*page_size,:);
    df = char(jsonencode({df}));

end