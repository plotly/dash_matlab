function df = callback1(page_current, page_size)
    data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/gapminder2007.csv', 'PreserveVariableNames', true);
    data.index = [1:1:height(data)]';
    data = movevars(data, 'index', 'Before', 'country');
    
    df = data(page_current*page_size+1:(page_current+1)*page_size,:);
    df = jsonencode(df);
end