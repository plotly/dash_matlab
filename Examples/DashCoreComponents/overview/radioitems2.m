terminate(pyenv);
clearvars;

uiFig = uifigure('visible', 'off');

buttonGroup = uibuttongroup(uiFig);   
radioButton1 = uiradiobutton(buttonGroup);
radioButton2 = uiradiobutton(buttonGroup);
radioButton3 = uiradiobutton(buttonGroup);
radioButton1.Text = 'New York City';
radioButton2.Text = 'Montréal';
radioButton3.Text = 'San Francisco';

dashButtonGroup = ui2dash(buttonGroup, 'bg1');

% Add radioitems to Dash app layout
components = {dashButtonGroup};

% Start app
startDash(components, 8057, [], 'SOLAR');
