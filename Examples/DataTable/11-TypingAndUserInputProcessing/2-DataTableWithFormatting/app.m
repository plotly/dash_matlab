clear all
close all
terminate(pyenv);

% Define data table
city = {'NYC';'Montreal';'Los Angeles'};
max = [108;99;111];
max_date = {'1926-07-22'; '1975-08-01'; '1939-09-20'};
min = [-15;-36;28];
min_date = {'1934-02-09'; '1957-01-15'; '1913-01-07'};
data = table(city,max,max_date,min,min_date);

% create Dash app
table_app = createApp();

% create ui elements
uifig = uifigure('visible', 'off');
uit = uitable(uifig, 'ColumnName', data.Properties.VariableNames, 'Data', data, 'visible', 'off');

sign = py.dash_table.Format.Sign;
scheme = py.dash_table.Format.Scheme;
symbol = py.dash_table.Format.Symbol;

% Define custom columns
[~, lncols] = size(uit.Data);
columns = {lncols};
columns{1} = struct('id','city','name','City','type','text');
columns{2} = struct('id','max','name','Max Temperature (˚F)','type','numeric',...
    'format', py.dash_table.Format.Format(pyargs(...
        'precision',py.int(0),...
        'scheme',scheme.fixed,...
        'symbol',symbol.yes,...
        'symbol_suffix','˚F')));
columns{3} = struct('id','max_date','name','Max Temperature (Date)','type','datetime');
columns{4} = struct('id','min','name','Min Temperature (˚F)','type','numeric',...
    'format', py.dash_table.Format.Format(pyargs(...
    'nully','N/A',...
        'precision',py.int(0),...
        'scheme',scheme.fixed,...
        'sign',sign.parantheses,...
        'symbol',symbol.yes,...
        'symbol_suffix','˚F')),...
    'on_change', struct('action','coerce','failure','default'),...
    'validation', struct('default', -1));
columns{5} = struct('id','min_date','name','Min Temperature (Date)','type','datetime',...
    'on_change', struct('action','none'));
columns = {columns};

% User data
uit.UserData = struct(...
    'columns', columns,...
    'editable', true,...
    'style_table',struct('overflowX','scroll'));

dash_table = ui2dash(uit, 'typing_formatting');

% add table to Dash app layout
table_app.layout = addLayout(dash_table);

% run the app
table_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))