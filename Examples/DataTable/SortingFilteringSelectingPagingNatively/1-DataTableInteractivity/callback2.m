function graphTable = callback2(rows, derived_virtual_selected_rows)
    data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/gapminder2007.csv', 'PreserveVariableNames', true);

    if isempty(derived_virtual_selected_rows)
        derived_virtual_selected_rows = {};
    end
    dff = data;
    %if isempty(rows)
    %    dff = data;
    %else
    %    dff = data(rows,:);
    %end
    
    colors = {height(dff)}; % height gives number of rows of data table

    for i=1:height(dff)
        if any(cellfun(@(x) isequal(x, i), derived_virtual_selected_rows))
            colors(i) = {'#7FDBFF'};
        else
            colors(i) = {'#0074D9'};
        end
    end
    colors = py.list(colors);
    
    graphTable = {};
    
    columns = ["pop"; "lifeExp"; "gdpPercap"];
    for i=1:length(columns)
        if any(cellfun(@(x) isequal(x, string(columns(i))), data.Properties.VariableNames))
            x = table2array(dff(:,'country'))';
            y = table2array(dff(:,columns(i)))';
            
            fig = py.dict(pyargs(...
                'data', py.list({py.dict(pyargs(...
                    'x', x,...
                    'y', y,...
                    'type', 'bar',...
                    'marker', py.dict(pyargs('color', colors))))}),...
                'layout', py.dict(pyargs(...
                    'xaxis', py.dict(pyargs('automargin', true)),...
                    'yaxis', py.dict(pyargs(...
                        'automargin', true,...
                        'title', py.dict(pyargs('text', string(columns(i)))))),...
                    'height', py.int(250),...
                    'margin', py.dict(pyargs('t', py.int(10), 'l', py.int(10), 'r', py.int(10)))))));
            
            graphTable{end+1} = py.dash_core_components.Graph(pyargs(...
                'id', string(columns(i)),...
                'figure', fig));
        end
    end
    
    graphTable = py.list(graphTable);
    diary('graphOut.txt');
    graphTable
    diary off
    

end
    