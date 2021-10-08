terminate(pyenv);
clearvars;

component = dashBio('Ideogram', {...
        'id', 'ideogram-size',...
        'chrHeight', 800,...
        'chrWidth', 100});  
    
components = {component};

% Run the app
startDash(components, 8057);