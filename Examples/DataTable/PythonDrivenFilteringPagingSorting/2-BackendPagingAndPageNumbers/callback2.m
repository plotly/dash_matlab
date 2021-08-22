function count = callback2(use_page_count, page_count_value)
    if isempty(use_page_count) || page_count_value == -1
        count = jsonencode(-1);
    else
        count = jsonencode(page_count_value);
    end
end