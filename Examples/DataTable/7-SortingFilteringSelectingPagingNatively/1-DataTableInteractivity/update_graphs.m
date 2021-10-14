function graphTable = update_graphs(rows, derived_virtual_selected_rows)
    data = readtable('https://git.io/JgqCd', 'PreserveVariableNames', true);

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
    colors = {colors};
    
    graphTable = {};
    
    columns = ["pop"; "lifeExp"; "gdpPercap"];
    xCountry = categorical(table2array(dff(:,'country')));
    for i=1:length(columns)
        if any(cellfun(@(x) isequal(x, string(columns(i))), data.Properties.VariableNames))
            subplot(3,1,i);
            
            y = table2array(dff(:,columns(i)));
            
            bar(xCountry,y)
            ylabel(string(columns(i)), 'FontSize', 14)
            %{
            fig = py.dict(pyargs(...
                'data', py.list({py.dict(pyargs(...
                    'x', py.list(x),...
                    'y', py.list(y),...
                    'type', 'bar',...
                    'marker', py.dict(pyargs('color', colors))))}),...
                'layout', py.dict(pyargs(...
                    'xaxis', py.dict(pyargs('automargin', true)),...
                    'yaxis', py.dict(pyargs(...
                        'automargin', true,...
                        'title', py.dict(pyargs('text', string(columns(i)))))),...
                    'height', py.int(250),...
                    'margin', py.dict(pyargs('t', py.int(10), 'l', py.int(10), 'r', py.int(10)))))));

            graphTable{end+1} = fig;
            %}

        end
    end

    %graphTable = char(py.json.dumps(py.list(graphTable)));
    fig = fig2plotly(gcf, 'offline', true, 'open', false, 'Visible', false);
    
    plotlyFig = {struct('data', {fig.('data')}, 'layout', fig.('layout'))};
    graphTable = char(jsonencode(plotlyFig));
    

end