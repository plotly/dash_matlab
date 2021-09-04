import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback(*args):
    outputs = eval('eng.'+callbackMatlabFunction+'(*args)')
    return outputs