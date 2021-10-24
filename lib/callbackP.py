import matlab.engine
import json
from dash.exceptions import PreventUpdate

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def render_content(*args):
    argsMat = ['NaN' if a is None else a for a in args]
    outputs = json.loads(eng.render_content(*argsMat))
    if outputs == 'PreventUpdate':
        raise PreventUpdate
    return outputs

