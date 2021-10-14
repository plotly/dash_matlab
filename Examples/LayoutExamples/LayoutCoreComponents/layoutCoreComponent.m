terminate(pyenv);
clearvars; % Removes all variables from the currently active workspace.

uiFigure = uifigure('visible', 'on');
size = [12, 12];
uiGrid = uigridlayout(uiFigure, size);

% Dropdown
dropdownLabel = uilabel(uiGrid, 'Text', 'Dropdown');
dropdownValues = {'New York City';'Montreal';'San Francisco'};
dropdown = uidropdown(uiGrid, 'Items', dropdownValues, 'Value', dropdownValues{1});

dropdownLabel.Layout.Row = 1;
dropdown.Layout.Row = 2;
dropdown.Layout.Column = [1, 6];

% Radio Items
radioItemsLabel = uilabel(uiGrid, 'Text', 'Radio Items');
buttonGroup = uibuttongroup(uiGrid);   
radioButton1 = uiradiobutton(buttonGroup);
radioButton2 = uiradiobutton(buttonGroup);
radioButton3 = uiradiobutton(buttonGroup);
radioButton1.Text = 'New York City';
radioButton2.Text = 'Montreal';
radioButton3.Text = 'San Francisco';

radioItemsLabel.Layout.Row = 3;
buttonGroup.Layout.Row = 4;

% Checkboxes
checklistLabel = uilabel(uiGrid, 'Text', 'Checkboxes');
box1 = uicheckbox(uiGrid);
box1.Text = 'New York City';
box1.Value = false;

box2 = uicheckbox(uiGrid);
box2.Text = 'Montreal';
box2.Value = true;

box3 = uicheckbox(uiGrid);
box3.Text = 'San Francisco';
box3.Value = true;

checklistLabel.Layout.Row = 5;
box1.Layout.Row = 6;
box2.Layout.Row = 7;
box3.Layout.Row = 8;

% Text Input
textInputLabel = uilabel(uiGrid, 'Text', 'Text Input');
textInput = uitextarea(uiGrid, 'Value', 'MTL');

textInputLabel.Layout.Row = 9;
textInput.Layout.Row = 10;

% Slider
sliderLabel = uilabel(uiGrid, 'Text', 'Slider');
slider = uislider(uiGrid);
slider.MajorTicks = [1,2,3,4,5,6];

sliderLabel.Layout.Row = 11;
slider.Layout.Row = 12;

% Run the app.
layoutApp = startDash(uiGrid, 8057);