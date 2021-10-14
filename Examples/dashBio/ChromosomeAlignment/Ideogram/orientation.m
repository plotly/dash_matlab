terminate(pyenv);
clearvars;

component = dashBio('Ideogram', {...
        'id', 'ideogram-orientation',...
        'orientation', 'horizontal'});  
    
components = {component};

% Run the app
startDash(components, 8057);