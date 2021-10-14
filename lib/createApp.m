function app = createApp(theme)
% Available Themes:
%
% CERULEAN, COSMO, CYBORG, DARKLY, FLATLY, JOURNAL, LITERA, 
% LUMEN, LUX, MATERIA, MINTY, PULSE, SANDSTONE, SIMPLEX, 
% SKETCHY, SLATE, SOLAR, SPACELAB, SUPERHERO, UNITED, YETI.
%
% Visit this link for more details:
% https://dash-bootstrap-components.opensource.faculty.ai/docs/themes/

    dbc = py.importlib.import_module('dash_bootstrap_components.themes');
    ext_stylesheets = py.list({dbc.(theme)});
    
    app = py.dash.Dash('__main__', pyargs('external_stylesheets', ext_stylesheets));
       
end