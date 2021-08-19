import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback(value):
    val = json.loads(eng.callback(value))
    return [val]
