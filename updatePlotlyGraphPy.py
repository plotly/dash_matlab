import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def updatePlotlyGraphPy(selected_year):
    fig = json.loads(eng.updatePlotlyGraph(selected_year))
    plotly_fig = {'data': fig['data'], 'layout': fig['layout']}
    return [plotly_fig]
