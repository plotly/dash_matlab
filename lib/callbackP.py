import matlab.engine
import json
from dash.exceptions import PreventUpdate

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def updateGraph(*args):
    if args[0] is None:
        outputs = json.loads(eng.updateGraph("NaN"))
    else:
        outputs = json.loads(eng.updateGraph(*args))
    if outputs == 'PreventUpdate':
        raise PreventUpdate
    return outputs

