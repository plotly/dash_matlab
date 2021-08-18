def callback1(selected_country):
    all_options = {
        'America': ['New York City', 'San Francisco', 'Cincinnati'],
        'Canada': [u'Montréal', 'Toronto', 'Ottawa']
    }
    return [[{'label': i, 'value': i} for i in all_options[selected_country]]]

def callback2(available_options):
    all_options = {
        'America': ['New York City', 'San Francisco', 'Cincinnati'],
        'Canada': [u'Montréal', 'Toronto', 'Ottawa']
    }
    return [available_options[0]['value']]

def callback3(selected_country, selected_city):
    all_options = {
        'America': ['New York City', 'San Francisco', 'Cincinnati'],
        'Canada': [u'Montréal', 'Toronto', 'Ottawa']
    }
    return [u'{} is a city in {}'.format(
        selected_city, selected_country,)]
