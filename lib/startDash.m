function app = startDash(uigrid, port, callbacks_dat, theme)
% Start dash server
%
% startDash(components, port, callbacks_dat, theme)
%
% components: array; a list of dash components or a uigridlayout
%
% port: number; the port where the app is set
%
% callbacks_dat: an array of callbacks arguments and handles
% if there are not callbacks, set this to []
%
% theme: string; dash_bootstrap_components theme for the app
% Available Themes:
% CERULEAN, COSMO, CYBORG, DARKLY, FLATLY, JOURNAL, LITERA, 
% LUMEN, LUX, MATERIA, MINTY, PULSE, SANDSTONE, SIMPLEX, 
% SKETCHY, SLATE, SOLAR, SPACELAB, SUPERHERO, UNITED, YETI.
%
% Visit this link for more details:
% https://dash-bootstrap-components.opensource.faculty.ai/docs/themes/
    % If theme is not set, make CERULEAN the default
    if ~exist('theme', 'var')
        theme = 'CERULEAN';
    end
    % If uigrid is NOT a uigridlayout,
    % then it has to be a set of components
    if ~isa(uigrid, 'matlab.ui.container.GridLayout')
        components = uigrid;
        app = createApp(theme);
        
        if exist('callbacks_dat', 'var')
            if ~isequal(callbacks_dat, [])
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
        end            
        
        app.layout = addLayout(components{:});
        app.run_server(pyargs('debug',true,'use_reloader',false,'port',num2str(port)));
    else
        %set id to each grid element
        set_ids(uigrid);
        %convert ui grid to dash
        ui_dash = uigrid2dash(uigrid.Children);
        %close figure
        close(uigrid.Parent);
        %init app
        app = createApp(theme);
        %check if callbacks passed
         if exist('callbacks_dat', 'var')    
             if ~isequal(callbacks_dat, [])
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
        end    
        %add layout
        mod=py.importlib.import_module('dash_bootstrap_components');
        app.layout = addLayout(py.dash.html.Div(...
            mod.wrapped.Container(ui_dash)));
        %start server
        app.run_server(pyargs('debug',true,'use_reloader',false,'port', num2str(port)))
    end
end
