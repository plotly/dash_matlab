function component = ui2dash(ui_widget, id)

    function hex = rgb2hex(rgb)
            if max(rgb(:))<=1
                rgb = round(rgb*255); 
            else
                rgb = round(rgb); 
            end
            hex(:,2:7) = reshape(sprintf('%02X',rgb.'),6,[]).'; 
            hex(:,1) = '#';
    end

    pad = 5; %padding in px
    switch ui_widget.Type
        case 'uislider'
            
            sld = ui_widget; 
            
            if isstruct(sld.UserData) % RangeSlider
                marks1 = sld.UserData.marks;
                slider_marks = py.dict();
                for i=1:length(marks1)
                    tick = string(marks1(i));
                    update(slider_marks, py.dict(pyargs(tick, tick)));
                end

                component = py.dash_core_components.RangeSlider(pyargs('id',id,...
                    'min', sld.UserData.min,...
                    'max', sld.UserData.max,...
                    'value', sld.UserData.value,...
                    'marks', slider_marks,...
                    'step', sld.UserData.step));                
            else
            
                slider_marks = py.dict();
                for i=1:length(sld.MajorTicks)
                    tick = string(sld.MajorTicks(i));
                    update(slider_marks, py.dict(pyargs(tick, tick)));
                end

                component = py.dash_core_components.Slider(pyargs('id',id, ...
                    'min', min(sld.MajorTicks),  ...
                    'max', max(sld.MajorTicks),  ...
                    'value', sld.Value,  ...
                    'marks', slider_marks, ...
                    'step', sld.MajorTicks(2)-sld.MajorTicks(1)));
            end
            
        case 'uibuttongroup'
            butgroup = ui_widget;              
            lnbut = length(butgroup.Buttons);
            opts = {lnbut};
            if lnbut>0
                for i=1:lnbut
                     opts{i} = py.dict(pyargs('label', butgroup.Buttons(i).Text, 'value', butgroup.Buttons(i).Text));
                end
                component = py.dash_core_components.RadioItems(pyargs('id', id, ...
                            'options', opts, ...
                            'value', butgroup.Buttons(1).Text, ...
                            'labelStyle', py.dict(pyargs('display', 'inline-block', 'padding', num2str(pad)+"px"))));
            else
                component = py.dash_core_components.RadioItems(pyargs('id', id, ...
                            'labelStyle', py.dict(pyargs('display', 'inline-block', 'padding', num2str(pad)+"px"))));                
            end
            
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
                
        % Lamp Properties
        case 'uilamp'
            l = ui_widget;
            if l.Enable == 'on'
                val = true;
            elseif l.Enable == 'off'
                val = false;
            end
            component = py.dash_daq.Indicator(pyargs(...
                'id',id,...
                'color', rgb2hex(l.Color),...
                'value', val));    
            

            
        % Gauge Properties
        case 'uigauge'
            g = ui_widget;
            colorRanges = py.dict();            
            for i=1:length(g.ScaleColors(:,1))                
                update(colorRanges, py.dict(pyargs(...
                    rgb2hex(g.ScaleColors(i,:)), py.list({...
                        py.int(g.ScaleColorLimits(i,1)),py.int(g.ScaleColorLimits(i,2))}))));
            end 
          
            component = py.dash_daq.Gauge(pyargs(...
                'id',id, 'value', g.Value,...
                'min', g.Limits(1), 'max', g.Limits(2),...
                'color', py.dict(pyargs(...
                    'ranges', colorRanges,...
                    'gradient', false))));
                
        % Linear Gauge Properties
        case 'uilineargauge'
            g = ui_widget;
            colorRanges = py.dict();            
            for i=1:length(g.ScaleColors(:,1))                
                update(colorRanges, py.dict(pyargs(...
                    rgb2hex(g.ScaleColors(i,:)), py.list({...
                        py.int(g.ScaleColorLimits(i,1)),py.int(g.ScaleColorLimits(i,2))}))));
            end 
          
            component = py.dash_daq.GraduatedBar(pyargs(...
                'id',id, 'value', g.Value,...
                'min', g.Limits(1), 'max', g.Limits(2),...
                'color', py.dict(pyargs(...
                    'ranges', colorRanges,...
                    'gradient', false))));
                
        % Knob Properties
        case 'uiknob'
            k = ui_widget;           
            component = py.dash_daq.Knob(pyargs(...
                'id',id, 'value', k.Value,...
                'min', k.Limits(1), 'max', k.Limits(2)));
            
        % Boolean Switch Properties
        case 'uiswitch'
            s = ui_widget;  

            component = py.dash_daq.BooleanSwitch(pyargs(...
                'id',id, 'on', false,...
                'disabled', strcmp(s.Enable, 'off'),...
                'vertical', strcmp(s.Orientation, 'vertical')));
            
        % Toggle Switch Properties
        case 'uitoggleswitch'
            s = ui_widget;           
            component = py.dash_daq.ToggleSwitch(pyargs(...
                'id',id, 'value', false, 'size', 100,...
                'disabled', strcmp(s.Enable, 'off'),...
                'vertical', strcmp(s.Orientation, 'vertical')));
            
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
                'id',id, 'children', lbl.Text,...
                'style', py.dict(pyargs(...
                    'font-size', lbl.FontSize,...
                    'font-weight', lbl.FontWeight,...
                    'color', rgb2hex(lbl.FontColor),...
                    'textAlign', lbl.HorizontalAlignment,...
                    'display', 'block'))));

        % Hyperlink Properties
        case 'uihyperlink'
            hlink = ui_widget;
            component = py.dash_core_components.Link(pyargs(...
                'id',id, 'href', hlink.URL, 'target', '_blank', 'children', hlink.Text));
        
        % Image Properties
        case 'uiimage'
            img = ui_widget;
            component = py.dash_html_components.Img(pyargs(...
                'id',id, 'src', img.ImageSource));

        % axes Properties
        case 'axes'
            axs = ui_widget;
            set(0,'DefaultFigureVisible','off');
            f=figure('visible','off');
            copyobj(axs,f);
            pfig = fig2plotly(f, 'offline', true,...
                'open', false,'Visible',false);
            if isstruct(axs.UserData)
                theme = axs.UserData.theme;
                addtheme(pfig, theme);
            end
            
            plotlyfig = plotlyfig2dash(pfig, axs.Tag);
            close(f);            
            component = plotlyfig;
        
        % DataTable Properties for html.Table and DataTable
        case 'uitable'
            % for datatable
            if isstruct(ui_widget.UserData)
                tb = ui_widget;
                [lnrows, lncols] = size(tb.Data);

                if ~isfield(tb.UserData, 'columns')
                    cols = {lncols};
                    for i=1:lncols
                        cols{i} = py.dict(pyargs('name', string(tb.ColumnName(i)), 'id', string(tb.ColumnName(i))));
                    end
                    tb.UserData.columns = py.list(cols);            
                end

                data = {lnrows};
                for i=1:lnrows
                    d = py.dict();
                    for j=1:lncols
                        try
                            update(d, py.dict(pyargs(string(tb.ColumnName(j)), tb.Data{i,j})));
                        catch e
                            if e.message == "Conversion of MATLAB 'datetime' to Python is not supported."
                                matlab_date = tb.Data{i,j};
                                daten = datenum(matlab_date);
                                days = rem(daten, 1);
                                date = py.datetime.date.fromordinal(py.int(daten)) +...
                                    py.datetime.timedelta(pyargs('days',days)) -...
                                    py.datetime.timedelta(pyargs('days', 366));

                                update(d, py.dict(pyargs(string(tb.ColumnName(j)), date)));
                            end
                        end
                    end
                    data{i} = d;
                end

                items = {'id', id,...
                    'data', py.list(data)};
                for item = fieldnames(tb.UserData)'
                    items{end+1} = char(item);
                    items{end+1} = tb.UserData.(char(item));
                end

                component = py.dash_table.DataTable(pyargs(items{:}));
            % for html.Table as container for other elements
            else    
                table = ui_widget;
                sz = size(table.Data);
                rows=py.list();
                for i=1:sz(1)
                    cols=py.list();
                    for j=1:sz( 2)
                        cl = py.dash_html_components.Td(pyargs( ...
                            'id', table.UserData(i, j), 'children', table.Data(i, j)));
                        cols.append(cl);
                    end                
                    rows.append(py.dash_html_components.Tr(cols));                
                end
                component = py.dash_html_components.Table(pyargs( 'children', rows));
             end
            
        % Tab group
        case 'uitabgroup'
            tabgr  = ui_widget;
            tabln = length(tabgr.Children);
            tabs = py.list();
            %tabs
            for i=1:tabln
                tb = tabgr.Children(i);
                %get tab children
                nestln = length(tb.Children());
                nest = py.list();
                %cycle through tab content
                for j=1:nestln
                    nest.append(ui2dash(tb.Children(j), tb.Children(j).Tag));
                end
                %add tab with tab content to group
                tabs.append(py.dash_core_components.Tab(pyargs( ...
                    'label', tb.Title, ...
                    'children', nest)));
            end
            %tab group
            component = py.dash_core_components.Tabs(pyargs('children', tabs, ...
                    'style', py.dict(pyargs('padding', num2str(pad)+"px"))));            
            
        %numeric edit field
        case 'uinumericeditfield'
            component = py.dash_core_components.Input(...
                pyargs('id', id, 'type', 'number', 'value', ui_widget.Value,...
                'min', ui_widget.Limits(1), 'max', ui_widget.Limits(2)));

        %text edit field
        case 'uieditfield'
            component = py.dash_core_components.Input(...
                pyargs('id', id, 'type', 'text', 'value', ui_widget.Value,...
                'placeholder', ui_widget.Placeholder));
    
    end
end
