import matlab.engine
import json
import dash

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback(btn1, btn2, btn3):
    changed_id = [p['prop_id'] for p in dash.callback_context.triggered][0]

    btn_sel = json.loads(eng.callback(btn1, btn2, btn3, changed_id))

    return [btn_sel]
