import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback(selected_year):
    fig = json.loads(eng.callback(selected_year))
    plotly_fig = {'data': fig['data'], 'layout': fig['layout']}
    return [plotly_fig]
