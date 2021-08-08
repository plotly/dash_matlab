terminate(pyenv);

% create Dash app
radioitems_app = createApp();

uifig = uifigure('visible', 'off');

bg1 = uibuttongroup(uifig);   
rb11 = uiradiobutton(bg1);
rb12 = uiradiobutton(bg1);
rb13 = uiradiobutton(bg1);
rb11.Text = 'Option 1';
rb12.Text = 'Option 2';
rb13.Text = 'Option 3';

dash_butgroup1 = ui2dash(bg1, 'bg1');

% add radioitems to Dash app layout
radioitems_app.layout = addLayout(py.dash_html_components.Div(dash_butgroup1));

% run the app

radioitems_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
