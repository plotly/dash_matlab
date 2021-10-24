terminate(pyenv);
clearvars;

dashLoading = Dcc('Loading',{'children', {...
    % ...
    }});

components = {dashLoading};

% Start app
startDash(components, 8057, [], 'SOLAR');