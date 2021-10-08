terminate(pyenv);
clearvars;

component = dashBio('Igv', {...
        'id', 'bases-igv',...
        'genome', 'ce11',...
        'minimumBases', '10'});  
    
components = {component};

% Run the app
startDash(components, 8057);