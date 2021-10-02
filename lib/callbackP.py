import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def update_graphs(*args):
    outputs = json.loads(eng.update_graphs(*args))
    return outputs

