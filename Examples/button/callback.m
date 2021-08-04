function msgDiv = callback(btn1, btn2, btn3, changed_id)
    %ctx = py.dash.callback_context;
    %things = length(ctx.triggered);
    %changed_id = {things};
    %for i = 1:things
    %    changed_id{i} = py.dash.callback_context.triggered(i);
    %end
    
    if any(changed_id(:) == 'btn_nclicks_1')
        msg = 'Button 1 was most recently clicked';
    elseif any(changed_id(:) == 'btn_nclicks_2')
        msg = 'Button 2 was most recently clicked';
    elseif any(changed_id(:) == 'btn_nclicks_3')
        msg = 'Button 3 was most recently clicked';
    else
        msg = 'None of the buttons have been clicked yet';
    end
    
    msgDiv = jsonencode(py.dash_html_components.Div(msg));

end
