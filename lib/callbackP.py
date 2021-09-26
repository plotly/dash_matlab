import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def updateGraph(*args):
    outputs = json.loads(eng.updateGraph(*args))
    return outputs

