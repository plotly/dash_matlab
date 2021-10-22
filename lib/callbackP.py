import matlab.engine
import json
from dash.exceptions import PreventUpdate

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def custom_copy(*args):
    if args[0] is None:
        outputs = json.loads(eng.custom_copy("NaN"))
    else:
        outputs = json.loads(eng.custom_copy(*args))
    if outputs == 'PreventUpdate':
        raise PreventUpdate
    return outputs

