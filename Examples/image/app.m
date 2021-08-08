terminate(pyenv);

% create Dash app
image_app = createApp();

uifig = uifigure('visible', 'off');

img_1 = uiimage(uifig);
img_1.ImageSource = 'assets/plotly-logo.png';
dash_img1 = ui2dash(img_1, 'img_1');

% add image to Dash app layout
image_app.layout = addLayout(py.dash_html_components.Div(...
    dash_img1));

% run the app
image_app.run_server(pyargs('debug',true,'use_reloader',false,'port','8057'))
