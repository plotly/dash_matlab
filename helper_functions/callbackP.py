import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def update_figure(*args):
    outputs = json.loads(eng.update_figure(*args))
    return outputs

