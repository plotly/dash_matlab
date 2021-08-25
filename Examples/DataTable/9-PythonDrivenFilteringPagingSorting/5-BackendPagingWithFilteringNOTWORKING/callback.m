function df = callback(page_current, page_size, filter)
    data1 = readtable('https://raw.githubusercontent.com/plotly/datasets/master/gapminder2007.csv', 'PreserveVariableNames', true);

    data2 = data1(:, sort(data1.Properties.VariableNames));
    
    filtering_expressions = split(filter, ' && ');
    
    for i=numel(filtering_expressions)
        filter_part = filtering_expressions{i};
        [col_name, operator, filter_value] = split_filter_part(filter_part);
    
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
    df = jsonencode(df);

end