function df = callback(page_current, page_size, sort_by)
    data1 = readtable('https://raw.githubusercontent.com/plotly/datasets/master/gapminder2007.csv', 'PreserveVariableNames', true);

    data2 = data1(:, sort(data1.Properties.VariableNames));
    
    s = size(sort_by);
    if s
        direction = {s(2)};
        cols = {s(2)};
        for i=1:s(2)
            cols{i} = sort_by{i}.column_id;
            if strcmp(sort_by{i}.direction, 'asc')
                direction{i} = 'ascend';                
            else
                direction{i} = 'descend';
            end
        end
        df = sortrows(data2, cols, direction);

    else
        df = data2;
    end   

    df = df(page_current*page_size+1:(page_current+1)*page_size,:);
    df = jsonencode(df);

end