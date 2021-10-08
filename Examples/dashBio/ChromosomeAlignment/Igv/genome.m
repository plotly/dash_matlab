terminate(pyenv);
clearvars;

component = dashBio('Igv', {...
        'id', 'genome-igv',...
        'genome', 'ce11'});  
    
components = {component};

% Run the app
startDash(components, 8057);