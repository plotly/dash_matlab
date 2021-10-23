function useCallback(myCallbacks)
% This function writes a Python callback file.
%
%  The new file is called in the background.
%
%  myCallbacks: name of matlab callbacks functions (cell of strings)
    
    pathToCallbackPyFile = fileparts(which('callbackP.py'));
    
    outFile = fopen(strcat(pathToCallbackPyFile, '\callbackP.py'), 'w');
    fprintf(outFile, 'import matlab.engine\n');
    fprintf(outFile, 'import json\n');
    fprintf(outFile, 'from dash.exceptions import PreventUpdate\n\n');
    fprintf(outFile, 'future = matlab.engine.start_matlab(background=True)\n');
    fprintf(outFile, 'eng = future.result()\n\n');
    
    for matlabCallback = myCallbacks        
        fprintf(outFile, 'def %s(*args):\n', matlabCallback{1});
        fprintf(outFile, "    argsMat = ['NaN' if a is None else a for a in args]\n");
        fprintf(outFile, "    outputs = json.loads(eng.%s(*argsMat))\n", matlabCallback{1});
        fprintf(outFile, "    if outputs == 'PreventUpdate':\n");
        fprintf(outFile, "        raise PreventUpdate\n");
        fprintf(outFile, '    return outputs\n\n');
    end
    
    fclose(outFile);

end