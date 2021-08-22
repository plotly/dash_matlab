function [name, operator_type, value] = split_filter_part(filter_part)
    % Input: '{continent} seq Asia'
    % Output: continent eq Asia

    % Input: '{gdpPercap} s> 5000'
    % Output: gdpPercap gt 5000.0
    operators = {...
        {'ge'; '>='},...
        {'le'; '<='},...
        {'lt'; '<'},...
        {'gt'; '>'},...
        {'ne'; '!='},...
        {'eq'; '='},...
        {'contains '},...
        {'datestartswith '}};

    for i=1:numel(operators)
        operator_type = operators{i};
        for j=1:numel(operator_type)
            
            operator = operator_type{j};
            three_parts = split(filter_part);
            op = three_parts{2};
            operator_type_r = op(2:end);
            
             if strcmp(operator_type_r, operator)   
                name = three_parts{1};
                name = extractBetween(name, '{', '}');
                name = name{1};
                value = three_parts{3};
                value = str2double(value);
                operator_type = operator_type{1};

                return
            end
        end
    end
    name = -1;
    operator_type = -1;
    value = -1;
end

