import matlab.engine
import json
from dash.exceptions import PreventUpdate

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def update_graphs(*args):
    argsMat = ['NaN' if a is None else a for a in args]
    outputs = json.loads(eng.update_graphs(*argsMat))
    if outputs == 'PreventUpdate':
        raise PreventUpdate
    return outputs

