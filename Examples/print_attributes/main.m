clear;clc;close all
terminate(pyenv);

%% Create dash axis UI
uifig = uifigure('Visible', 'off');

%% Create the scatter plot
x = randn(1,10);
y= 1:10;
f1 = figure(1);
scatter(x,y, 60, 'filled', 'o', 'LineWidth',1.5, 'MarkerFaceColor',[0 .7 .7], ...
    'MarkerEdgeColor',[0 .5 .5]);
grid('on');
fig = plotlyfig2dash(fig2plotly(f1, 'offline', true, 'open', false,'Visible', false), 'basic-interactions');

%% Display Figure attributes : Layout components
styles = py.dict(pyargs('pre', py.dict(pyargs('border', 'thin lightgrey solid', 'overflowX', 'scroll'))));

Hoverstring = sprintf(['**Hover Data**\n' '\n' 'Mouse over values in the graph']);
Clickstring = sprintf(['**Click Data**\n' '\n' 'Click on points in the graph']);    
Selectionstring = sprintf(['**Selection Data ** \n' '\n' 'Choose the lass or rectangle tool in ' ...
    'the graphs menu''s bar and then select points in the graph.\n' '\n'...
    'Note that if Layout.clickmode = "event+select", selection data also accumulates' ...
    '(or un-accumlates) selected data if you hold down the shift button while clicking' ]);
Zoomstring = sprintf(['**Zoom and Relayout Data**\n' '\n' ...
    'Click and drag on the graph to zoom or click on the zoom buttons in the graph''s menu bar.\n' '\n'...
    'Clicking on legend items will also fire this event.']);

Hover_div_md = py.dash_core_components.Markdown(Hoverstring);
test_dic = py.dict(pyargs('X','1.24 + I love Python', 'Y', '2.5'));
Pre_hover = py.dash_html_components.Pre(pyargs('id', 'hover-data', ...
                                        'style', styles{'pre'}));
Hover_Div = py.dash_html_components.Div({Hover_div_md, Pre_hover}, pyargs('className', 'three columns'));

Click_div_md = py.dash_core_components.Markdown(Clickstring);
Pre_click = py.dash_html_components.Pre(pyargs('id', 'click-data', 'style', styles{'pre'}));
Click_Div = py.dash_html_components.Div({Click_div_md, Pre_click}, pyargs('className', 'three columns'));

Select_div_md = py.dash_core_components.Markdown(Selectionstring);
Pre_select = py.dash_html_components.Pre(pyargs('id', 'selected-data', 'style', styles{'pre'}));
Select_Div = py.dash_html_components.Div({Select_div_md, Pre_select}, pyargs('className', 'three columns'));

Zoom_div_md = py.dash_core_components.Markdown(Zoomstring);
Pre_Zoom = py.dash_html_components.Pre(pyargs('id', 'relayout-data', 'style', styles{'pre'}));
Zoom_Div = py.dash_html_components.Div({Zoom_div_md,Pre_Zoom}, pyargs('className', 'three columns'));

row_div = py.dash_html_components.Div(pyargs('className', 'row', ...
    'children', {Hover_Div, Click_Div, Select_Div,  Zoom_Div}));

%% Create the App 
print_attr_app = createApp();
print_attr_app.layout = addLayout(py.dash_html_components.Div({fig, row_div}));
%% Callbacks 
InputArgs1 = argsIn('basic-interactions', 'hoverData');
InputArgs2 = argsIn('basic-interactions', 'clickData');
InputArgs3 = argsIn('basic-interactions', 'selectedData');
InputArgs4 = argsIn('basic-interactions', 'relayoutData');


OutputArgs1 = argsOut('hover-data', 'children');
OutputArgs2 = argsOut('click-data', 'children');
OutputArgs3 = argsOut('selected-data', 'children');
OutputArgs4 = argsOut('relayout-data', 'children');

mycallbackappcallback = print_attr_app.callback({OutputArgs1,OutputArgs2, OutputArgs3, ...
    OutputArgs4, InputArgs1, InputArgs2, InputArgs3, InputArgs4});
mycallbackappcallback(@py.callback.callback);
%% Run the app
print_attr_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'));