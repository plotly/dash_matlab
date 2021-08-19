import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback(on):
    val = json.loads(eng.callback(on))
    return [val]
