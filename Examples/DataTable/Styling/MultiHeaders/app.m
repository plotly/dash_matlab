clear all
close all
terminate(pyenv);

% read data file
data = readtable('https://raw.githubusercontent.com/plotly/datasets/master/medicare_cost.csv', 'PreserveVariableNames', true);
try
    data = data([1:10],[1:7]); % Select first 10 rows and first 7 columns
catch
end

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

%% Define struct which stores uitable properties like styling
% An example with cell and header stylings,
% as well as page_size property is provided:
%{
uit.UserData = struct(...
    'style_cell', struct(...
        'page_size', 3,...
        'textAlign', 'center',...
        'backgroundColor', 'rgb(50,50,50)',...
        'color', 'white',...
        'font_size', '16px',...
        'padding', '5px'),...
    'style_header', struct(...
        'backgroundColor', 'rgb(30,30,30)',...
        'fontWeight', 'bold'),...
    'page_size', 10);
%}
%%

[lnrows, lncols] = size(uit.Data);
customColumns = {lncols};
customColumns{1} = py.dict(pyargs('name', py.list({'','City, State'}), 'id', 'City, State'));
customColumns{2} = py.dict(pyargs('name', py.list({'Props1','Classification'}), 'id', 'Classification'));
customColumns{3} = py.dict(pyargs('name', py.list({'Props1','Definition'}), 'id', 'Definition'));
customColumns{4} = py.dict(pyargs('name', py.list({'Props1','DRG'}), 'id', 'DRG'));
customColumns{5} = py.dict(pyargs('name', py.list({'Props1','Hospit Reg Descr'}), 'id', 'Hospital Referral Region Description'));
customColumns{6} = py.dict(pyargs('name', py.list({'Providers','Prov City'}), 'id', 'Provider City'));
customColumns{7} = py.dict(pyargs('name', py.list({'Providers','Prov Id'}), 'id', 'Provider Id'));

customColumns = py.list(customColumns);

uit.UserData = struct(...
    'customColumns', customColumns,...
    'merge_duplicate_headers', true);

dash_table = ui2dash(uit, 'table');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))