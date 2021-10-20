function encodedObject = plotlyJsonEncoder(myObject)
    plotlyMod = py.importlib.import_module('plotly.utils');
    encodedObject = char(py.json.dumps({myObject}, pyargs(...
        'cls', plotlyMod.PlotlyJSONEncoder)));
end

