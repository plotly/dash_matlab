import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback1(value):
    dat = json.loads(eng.callback1(value))
    return [dat]

def callback2(jsonified_cleaned_data):
    dat = json.loads(eng.callback2(jsonified_cleaned_data))
    return [dat]

def callback3(jsonified_cleaned_data):
    dat = json.loads(eng.callback3(jsonified_cleaned_data))
    return [dat]