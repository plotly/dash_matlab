% set id to all grid components in UserData property
function map = set_ids(uigrid, map, nest)
    %pass dict with element count through recursion
    if ~exist('map','var')        
        map = containers.Map;  %dict with element count
    end
    %nesting count
    if ~exist('nest','var')
        nest = 0;
    end    
    chln = length(uigrid.Children);
    for i=1:chln
        ch = uigrid.Children(i);
        type = string(ch.Type);
        if isKey(map, type)
            map(type) = map(type) + 1;
        else
            map(type) = 1;
        end
        %set only if empty
        if isempty(ch.UserData)
            ch.UserData = type + "_" + num2str(nest) + "_" + num2str(map(type));
        end
        %recursively set id to its children, with passed elem counter
        if isprop(ch, 'Children')           
            set_ids(ch, map, nest+1);
        end
    end
end