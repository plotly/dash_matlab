function dic = display_output(rows, columns)

    z = {};
    for row=rows
        r = struct2cell(row{1})';
        z{end+1} = r;
    end

    z = {z};

    x = {};
    for col=columns
        x{end+1} = col{1}.name;      
    end
    x = {x};

    data = struct(...
        'type', 'heatmap',...
        'z', z,...
        'x', x);
    data = {{data}};
    
    dic = struct('data', data);
 
    dic = char(py.json.dumps(dic));

end