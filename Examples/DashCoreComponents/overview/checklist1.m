terminate(pyenv);
clearvars;

% Add boxes to Dash app layout
uiFig = uifigure('visible', 'off');

box1 = uicheckbox(uiFig);
box1.Text = 'New York City';
box1.Value = true;
dashBox1 = ui2dash(box1, 'NYC');

box2 = uicheckbox(uiFig);
box2.Text = 'Montréal';
box2.Value = true;
dashBox2 = ui2dash(box2, 'MTL');

box3 = uicheckbox(uiFig);
box3.Text = 'San Francisco';
box3.Value = false;
dashBox3 = ui2dash(box3, 'SF');

components = {dashBox1, dashBox2, dashBox3};

% Start app
startDash(components, 8057, [], 'SOLAR');
