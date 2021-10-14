function bioComponent = dashBio(method, properties)
% dash_bio components
%
%  dashBio(method, properties)
%
%  method: string.
%  properties: cell array containing name-value pairs with properties.
%
%  For example, a dash_bio.NglMoleculeViewer(id='myId') would be
%  done like:
%
%  dashBio('NglMoleculeViewer', {'id', 'myId'})
    try
        bioComponent = py.dash_bio.(method)(pyargs(properties{:}));
    catch
fileID = fopen('outsMat.txt','w');
o = matlab.unittest.diagnostics.ConstraintDiagnostic.getDisplayableString(properties);
fprintf(fileID, '%s\n', o);
fclose(fileID);
        
        a = char(jsonencode(properties));
        b = py.json.loads(a);
        c = cell(b);
        bioComponent = py.dash_bio.(method)(pyargs(c{:}));
    end
end