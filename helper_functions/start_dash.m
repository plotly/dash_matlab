%start dash server
function app = start_dash(uigrid, port, callbacks_dat)
    %set id to each grid element
    set_ids(uigrid);
    %convert ui grid to dash
    ui_dash = uigrid2dash(uigrid.Children);
    %close figure
    close(uigrid.Parent);
    %init app
    app = createApp();
    %check if callbacks passed
     if exist('callbacks_dat', 'var')       
         %iterate callbacks
         for i=1:size(callbacks_dat, 1)
            args = callbacks_dat{i, 1};   %callback arguments
            handle = callbacks_dat{i, 2};    %callback handle
            callbackfun = app.callback(args);
            callbackfun(handle);
        end
    end    
    %add layout
    app.layout = addLayout(py.dash_html_components.Div(py.dash_bootstrap_components.Container(ui_dash)));
    %start server
    app.run_server(pyargs('debug',true,'use_reloader',false,'port', num2str(port)))
end
