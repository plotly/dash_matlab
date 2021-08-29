clear all
close all
terminate(pyenv);

% read data file
data = readtable('condForm3.csv', 'PreserveVariableNames', true);

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

n_bins = 5;
bounds = {n_bins+1};
for i=1:n_bins+1
    bounds{i} = (i-1)*(1.0/n_bins);
end
numCols = ["2017", "2018", "2019", "2020"];
maxVal = max(max(data{:,2:end}));
minVal = min(min(data{:,2:end}));

ranges = {length(bounds)};
for i=1:length(bounds)
    ranges{i} = ((maxVal-minVal)*bounds{i})+minVal;
end

styles = {};
legend = {};
scs = py.colorlover.scales;

for i=2:length(bounds)
    
    min_bound = ranges{i-1};
    max_bound = ranges{i};
    backgroundColor = scs{num2str(n_bins)}{'seq'}{'Blues'}{i-1};
    if i > length(bounds)/2
        color = 'white';
    else
        color = 'inherit';
    end
    
    for c=1:length(numCols)
        col = numCols(c);
        if i < length(bounds)-2
            cond = sprintf('{''%s''} >= %d && {''%s''} < %d', col, min_bound, col, max_bound);
        else
            cond = sprintf('{''%s''} >= %d', col, min_bound);
        end
        styles{end+1} = struct(...
            'if', struct('filter_query', cond,...
            'column_id', sprintf("'%s'", col)),...
            'backgroundColor', backgroundColor,...
            'color', color);
    end
        
    legend{end+1} = py.dash_html_components.Div(pyargs(...
        'style', py.dict(pyargs(...
            'display', 'inline-block',...
            'width', '60px')),...
        'children', py.list({py.dash_html_components.Div(pyargs(...
            'style', py.dict(pyargs(...
                'backgroundColor', backgroundColor,...
                'borderLeft', '1px rgb(50, 50, 50) solid',...
                'height', '10px')))),...
                    py.dash_html_components.Small(...
                        round(min_bound,2), pyargs('style', py.dict(pyargs('paddingLeft', '2px'))))})));
  
     
end
style_data_conditional = py.list(styles);
legends = py.list(legend);

uit.UserData = struct(...
    'sort_action', 'native',...
    'style_data_conditional', style_data_conditional);

dash_table = ui2dash(uit, 'table');

html_legend = py.dash_html_components.Div(legends, pyargs('style',py.dict(pyargs(...
    'padding','5px 0 5px 0'))));

dash_legend = py.dash_html_components.Div(py.list({html_legend}), pyargs('style', py.dict(pyargs(...
    'float', 'right'))));

% add table to Dash app layout
table_app.layout = addLayout(dash_legend, dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))