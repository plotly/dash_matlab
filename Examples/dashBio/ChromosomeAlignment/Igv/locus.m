terminate(pyenv);
clearvars;

component = dashBio('Igv', {...
        'id', 'locus-igv',...
        'genome', 'ce11',...
        'locus', {'chrV', 'chrII'}});  
    
components = {component};

% Run the app
startDash(components, 8057);