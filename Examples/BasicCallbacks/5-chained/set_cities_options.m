function output = set_cities_options(selected_country)

    all_options = struct(...
        'America', {{'New York City', 'San Francisco', 'Cincinnati'}},...
        'Canada', {{'Montréal', 'Toronto', 'Ottawa'}});
    
    cities = all_options.(selected_country);
    output = {length(cities)};
    for i = 1:length(cities)
        output{i} = struct('label', string(cities{i}), 'value', string(cities{i}));
    end

    output = char(jsonencode({output}));

end