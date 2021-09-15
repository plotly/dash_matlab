import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def update_output_div(*args):
    outputs = json.loads(eng.update_output_div(*args))
    return outputs

