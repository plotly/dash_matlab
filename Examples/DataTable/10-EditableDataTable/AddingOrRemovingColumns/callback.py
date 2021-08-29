import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback1(n_clicks, value, existing_columns):
    cols = json.loads(eng.callback1(n_clicks, value, existing_columns))
    return [cols]

def callback2(rows, columns):
    d = json.loads(eng.callback2(rows, columns))
    return [d]