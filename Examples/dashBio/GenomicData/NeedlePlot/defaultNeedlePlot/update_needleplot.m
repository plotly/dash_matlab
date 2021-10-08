function out = update_needleplot(show_rangeslider)   
fileID = fopen('outsMat.txt','w');
o = matlab.unittest.diagnostics.ConstraintDiagnostic.getDisplayableString(show_rangeslider);
fprintf(fileID, '%s\n', o);

    if show_rangeslider
        out = true;
    else
        out = false;
    end
    out = char(jsonencode({show_rangeslider}));
    
o = matlab.unittest.diagnostics.ConstraintDiagnostic.getDisplayableString(out);
fprintf(fileID, '%s\n', o);
fclose(fileID);    
end
