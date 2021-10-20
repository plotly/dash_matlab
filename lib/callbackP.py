import matlab.engine
import json
from dash.exceptions import PreventUpdate

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def render_content(*args):
    if args[0] is None:
        outputs = json.loads(eng.render_content("NaN"))
    else:
        outputs = json.loads(eng.render_content(*args))
    if outputs == 'PreventUpdate':
        raise PreventUpdate
    return outputs

