import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback(txt1):

    outTxt = json.loads(eng.callback(txt1))

    outTxt = 'You have selected: "{}"'.format(txt1)

    return [outTxt]
