terminate(pyenv);

% create Dash app
checkbox_app = createApp();

% add boxes to Dash app layout
uifig = uifigure('visible', 'off');

box1 = uicheckbox(uifig);
box1.Text = 'Option 1';
box1.Value = false;
dash_box1 = ui2dash(box1, 'box1');

box2 = uicheckbox(uifig);
box2.Text = 'Option 2';
box2.Value = true;
dash_box2 = ui2dash(box2, 'box2');

box3 = uicheckbox(uifig);
box3.Text = 'Option 3';
box3.Value = false;
dash_box3 = ui2dash(box3, 'box3');

% add boxes to Dash app layout
checkbox_app.layout = addLayout(py.dash_html_components.Div({...
    dash_box1, dash_box2, dash_box3}));

% run the app

checkbox_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
