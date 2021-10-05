import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def update_clustergram(*args):
    outputs = json.loads(eng.update_clustergram(*args))
    return outputs

