%start dash server
function app = start_dash(uigrid, port)
    %set id to each grid element
    set_ids(uigrid);
    %convert ui grid to dash
    ui_dash = uigrid2dash(uigrid.Children);
    %init app
    app = createApp();
    %add layout
    app.layout = addLayout(py.dash_html_components.Div(py.dash_bootstrap_components.Container(ui_dash)));
    %start server
    app.run_server(pyargs('debug',true,'use_reloader',false,'port', num2str(port)))
end
