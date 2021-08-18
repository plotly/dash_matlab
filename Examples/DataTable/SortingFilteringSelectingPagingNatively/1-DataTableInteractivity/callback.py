import matlab.engine
import json
import pandas as pd
import dash_core_components as dcc
from dash_core_components import Graph
import numpy as np
from array import array

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback1(selected_columns):
    d = json.loads(eng.callback1(selected_columns))

    if d == [0]:
        d = []
    return [d]

def callback2(rows, derived_virtual_selected_rows):
    w = eng.callback2(rows, derived_virtual_selected_rows)
    f2 = open('graphOut.txt','r')
    graph_table = f2.read().split('with no properties.\n')[-1].strip()

    return [eval(graph_table)]
    