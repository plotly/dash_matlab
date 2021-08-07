function component = ui2dash(ui_widget, id)

    switch ui_widget.Type
        case 'uislider'
            
            sld = ui_widget; 
            
            slider_marks = py.dict();
            for i=1:length(sld.MajorTicks)
                tick = string(sld.MajorTicks(i));
                update(slider_marks, py.dict(pyargs(tick, tick)));
            end

            component = py.dash_core_components.Slider(pyargs('id',id, ...
                'min', min(sld.MajorTicks),  ...
                'max', max(sld.MajorTicks),  ...
                'value', min(sld.Value),  ...
                'marks', slider_marks, ...
                'step', round(max(sld.MajorTicks)/length(sld.MajorTicks))));
            
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
        
        % DropDown Properties
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
        
        % CheckBox Properties
        case 'uicheckbox'
            chkbox = ui_widget;
            
            opts = {1};
            opts{1} = py.dict(pyargs('label', chkbox.Text, 'value', chkbox.Text));
            
            if chkbox.Value == false
                component = py.dash_core_components.Checklist(pyargs('id', id, ...
                    'options', opts, 'value', {})); 
            else
              
                component = py.dash_core_components.Checklist(pyargs('id', id, ...
                    'options', opts, 'value', {chkbox.Text}));
            end
            
        % TextArea Properties
        case 'uitextarea'
            txt = ui_widget;
            lenTxt = length(txt.Value);
            values = '';
            for i = 1:lenTxt-1
                values = strcat(values, txt.Value{i}, '\n');
            end
            values = strcat(values, txt.Value{lenTxt});
            values = sprintf(values);
            component = py.dash_core_components.Textarea(pyargs(...
                'id', id, ...
                'value', values, ...
                'style', py.dict(pyargs('width', '50%', 'height', 150, 'font-size', 14))));

            
        % Label Properties
        case 'uilabel'
            lbl = ui_widget;
            component = py.dash_html_components.Label(pyargs(...
                'id',id, 'children', lbl.Text));

        % Hyperlink Properties
        case 'uihyperlink'
            hlink = ui_widget;
            component = py.dash_html_components.Img(pyargs(...
                'id',id, 'href', hlink.URL, 'target', '_blank', 'children', hlink.Text));
        
        % Image Properties
        case 'uiimage'
            img = ui_widget;
            component = py.dash_html_components.Img(pyargs(...
                'id',id, 'src', img.ImageSource));

        
        % Table Properties (TODO)
        case 'uitable'
            sld = ui_widget
            component = py.dash_html_components.Table(pyargs(...
                'children',sld.Data))
            

            
    end
end
