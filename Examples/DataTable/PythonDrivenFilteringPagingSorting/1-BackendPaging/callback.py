import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback(page_current,page_size):
    df = json.loads(eng.callback(page_current,page_size))
    return [df]