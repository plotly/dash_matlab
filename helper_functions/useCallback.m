function handle = useCallback(myCallback)
% myCallback: name of matlab callback function (string)
% handle: python handle function returned

    pathToCallbackPyFile = fileparts(which('callbackP.py'));
    
    P = py.sys.path;
    if count(P,pathToCallbackPyFile) == 0
        insert(P,int32(0),pathToCallbackPyFile);
    end
    
    mod = py.importlib.import_module('callbackP');

    py.setattr(mod, 'callbackMatlabFunction', myCallback);
    handle = @py.callbackP.callback;
end