import matlab.engine
import json
from dash.exceptions import PreventUpdate

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def update_output(*args):
    argsMat = ['NaN' if a is None else a for a in args]
    outputs = json.loads(eng.update_output(*argsMat))
    if outputs == 'PreventUpdate':
        raise PreventUpdate
    return outputs

