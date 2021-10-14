function encodedObject = plotlyJsonEncoder(myObject)
    plotlyMod = py.importlib.import_module('plotly');
    encodedObject = char(py.json.dumps({myObject}, pyargs(...
        'cls', plotlyMod.utils.PlotlyJSONEncoder)));
end

