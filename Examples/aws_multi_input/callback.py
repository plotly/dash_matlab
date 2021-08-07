import matlab.engine
import json

future = matlab.engine.connect_matlab(name="eng",background=True)
eng = future.result()

def callback(xaxis_column_name, yaxis_column_name, xaxis_type,yaxis_type, year_value):
    fig = json.loads(eng.callback(xaxis_column_name, yaxis_column_name, xaxis_type,yaxis_type, year_value))
    plotly_fig = {'data': fig['data'], 'layout': fig['layout']}
    return [plotly_fig]
