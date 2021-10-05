terminate(pyenv);
clearvars;

component = dashBio('Ideogram', {...
        'id', 'my-dashbio-ideogram',...
        'chrHeight', 250});  
    
components = {component};

% Run the app
startDash(components, 8057);