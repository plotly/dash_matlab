clear 
close all
% Read the data
Apple_data = importfile("data.xlsx", "Apple", [2, 1158]);

% create Dash app

stock_ticker = createApp();
uifig = uifigure('visible', 'on');
fig = uifigure;
dd = uidropdown(fig, 'Items',{'Apple','Coke','Tesla'}, 'value', 'Apple');

dash_dropd1 = ui2dash(dd, "stock");
close(fig)
% Initial plot
plot(Apple_data.Close, 'LineWidth', 1)

fig = plotlyfig2dash(fig2plotly(gcf, 'offline', true, 'open', false,'Visible', false), 'lineplot');

stock_ticker.layout = addLayout(addLayout(py.dash_html_components.Div({ ...
    py.dash_html_components.Div({dash_dropd1})})), ...
    py.dash_html_components.Div({fig}));

% define the callbacks
stock_ticker_callback = stock_ticker.callback( {argsOut('lineplot', 'figure'), argsIn("stock",'value') });  
stock_ticker_callback(@py.callback.callback);

% run the app

stock_ticker.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))