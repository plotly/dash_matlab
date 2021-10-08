terminate(pyenv);
clearvars;

component = dashBio('Ideogram', {...
        'id', 'ideogram-rotate',...
        'rotatable', false});  
    
components = {component};

% Run the app
startDash(components, 8057);