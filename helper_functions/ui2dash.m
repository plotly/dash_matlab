function component = ui2dash(ui_widget, id)

    switch ui_widget.Type
        case 'uislider'
            
            sld = ui_widget;
            
            slider_marks = py.dict();
            for i=1:length(sld.MajorTicks)
                tick = string(sld.MajorTicks(i));
                update(slider_marks, py.dict(pyargs(tick, tick)));
            end

            component = py.dash_core_components.Slider(pyargs('id', id, ...
            'min', min(sld.MajorTicks),  ...
            'max', max(sld.MajorTicks),  ...
            'value', sld.MajorTicks(1),  ...
            'marks', slider_marks, ...
            'step', round(median(diff(sld.MajorTicks)))));
    
        case 'uibuttongroup'
            butgroup = ui_widget;
              
            lnbut = length(butgroup.Buttons);
            opts = {lnbut};
            for i=1:lnbut
                 opts{i} = py.dict(pyargs('label', butgroup.Buttons(i).Text, 'value', butgroup.Buttons(i).Text));
            end
            component = py.dash_core_components.RadioItems(pyargs('id', id, ...
            'options', opts, ...
            'value', butgroup.Buttons(1).Text, ...
            'labelStyle', py.dict(pyargs('display', 'inline-block')))   );
           
        case 'uidropdown'
            drpdown = ui_widget;
               
            lnbut = length(drpdown.Items);
            opts = {lnbut};
            for i=1:lnbut
                opts{i} = py.dict(pyargs('label', drpdown.Items{i}, 'value', drpdown.Items{i}));
            end

            component = py.dash_core_components.Dropdown(pyargs('id', id, ...
            'options', opts, 'value', drpdown.Value ));
            
        % Button Properties
        case 'uibutton'
            btn = ui_widget;
            component = py.dash_html_components.Button(btn.Text, pyargs(...
                'id',id, 'n_clicks', 0 ));
                
        % DatePicker Properties
        case 'uidatepicker'
            dt = ui_widget;
            date1 = char(dt.Limits(1));
            date2 = char(dt.Limits(2));
            component = py.dash_core_components.DatePickerSingle(pyargs(...
                'id','my-date-picker-single',...
                'min_date_allowed',py.datetime.datetime.strptime(date1, '%m/%d/%Y'),...
                'max_date_allowed',py.datetime.datetime.strptime(date2, '%m/%d/%Y'),...
                'initial_visible_month',py.datetime.datetime.strptime(date1, '%m/%d/%Y'),...
                'date',py.datetime.datetime.strptime(date1, '%m/%d/%Y')));
    end
end
