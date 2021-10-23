function outCsv = custom_copy(data)
%fileID = fopen('outsMat.txt','w');
%o = matlab.unittest.diagnostics.ConstraintDiagnostic.getDisplayableString(data);
%fprintf(fileID, '%s\n', o);
%fclose(fileID);

    outCsv = jsonencode({data});
end

