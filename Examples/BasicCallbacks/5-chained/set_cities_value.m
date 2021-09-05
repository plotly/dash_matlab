function output = set_cities_value(available_options)
    output = jsonencode({available_options{1}.('value')});
end