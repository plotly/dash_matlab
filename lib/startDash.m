%start dash server
function app = startDash(uigrid, port, callbacks_dat)
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
         useCallback({callbacks_dat{:, 2}});
         
         pathToCallbackPyFile = fileparts(which('callbackP.py'));
        P = py.sys.path;
        if count(P,pathToCallbackPyFile) == 0
            insert(P,int32(0),pathToCallbackPyFile);
        end           
    
         py.importlib.import_module('callbackP');
         
         for i=1:size(callbacks_dat, 1)
            args = callbacks_dat{i, 1};   %callback arguments
            method = strcat('@py.callbackP.', (callbacks_dat{i, 2}));
            handle = str2func(method);    %callback handle
            callbackfun = app.callback(args);
            callbackfun(handle);
        end
    end    
    %add layout
    app.layout = addLayout(py.dash_html_components.Div(py.dash_bootstrap_components.Container(ui_dash)));
    %start server
    app.run_server(pyargs('debug',true,'use_reloader',false,'port', num2str(port)))
end
