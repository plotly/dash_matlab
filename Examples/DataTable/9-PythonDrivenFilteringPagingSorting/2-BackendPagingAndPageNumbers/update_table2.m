function count = update_table2(use_page_count, page_count_value)
    if isempty(use_page_count) || page_count_value == -1
        count = char(jsonencode({-1}));
    else
        count = char(jsonencode({page_count_value}));
    end
end