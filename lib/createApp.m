function app = createApp()
    
    dct = py.dict(pyargs('href', 'https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css', ...
        'rel', 'stylesheet', ...
        'integrity', 'sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO', ... % what the hell is this?
        'crossorigin', 'anonymous' ));

    ext_stylesheets = py.list({py.str('https://codepen.io/chriddyp/pen/bWLwgP.css'), dct});
    
    app = py.dash.Dash('__main__', pyargs('external_stylesheets', ext_stylesheets));
       
end