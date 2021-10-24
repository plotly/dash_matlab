import matlab.engine
import json
from dash.exceptions import PreventUpdate

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def number_render(*args):
    argsMat = ['NaN' if a is None else a for a in args]
    outputs = json.loads(eng.number_render(*argsMat))
    if outputs == 'PreventUpdate':
        raise PreventUpdate
    return outputs

