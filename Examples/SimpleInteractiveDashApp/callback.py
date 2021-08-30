import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback(input_value):
    outTxt = json.loads(eng.callback(input_value))
    return [outTxt]
