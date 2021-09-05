function output = set_display_children(selected_country, selected_city)  
    output = jsonencode({sprintf('%s is a city in %s', selected_city, selected_country)});
end

