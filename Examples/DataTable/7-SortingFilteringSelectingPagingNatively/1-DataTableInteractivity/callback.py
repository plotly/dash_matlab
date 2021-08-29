import matlab.engine
import json
from dash_core_components import Graph

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback1(selected_columns):
    d = json.loads(eng.callback1(selected_columns))

    if d == [0]:
        d = []
    return [d]

def callback2(rows, derived_virtual_selected_rows):
    w = json.loads(eng.callback2(rows, derived_virtual_selected_rows))

    return [[
        Graph(
            id=column,
            figure=w[i])
        for i, column in enumerate(["pop","lifeExp","gdpPercap"])
    ]]
    