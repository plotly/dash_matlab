function useCallback(myCallbacks)
% myCallbacks: name of matlab callbacks functions (cell of strings)
    
    pathToCallbackPyFile = fileparts(which('callbackP.py'));
    
    outFile = fopen(strcat(pathToCallbackPyFile, '\callbackP.py'), 'w');
    fprintf(outFile, 'import matlab.engine\n');
    fprintf(outFile, 'import json\n\n');
    fprintf(outFile, 'future = matlab.engine.start_matlab(background=True)\n');
    fprintf(outFile, 'eng = future.result()\n\n');
    
    for matlabCallback = myCallbacks
        fprintf(outFile, 'def %s(*args):\n', matlabCallback{1});
        fprintf(outFile, "    outputs = json.loads(eng.%s(*args))\n", matlabCallback{1});
        fprintf(outFile, '    return outputs\n\n');
    end
    
    fclose(outFile);

end