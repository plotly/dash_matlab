import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback1(page_current,page_size):
    df = json.loads(eng.callback1(page_current,page_size))
    return [df]

def callback2(use_page_count, page_count_value):
    if page_count_value is None:
        page_count_value = -1
    count = json.loads(eng.callback2(use_page_count, page_count_value))
    if count == -1: count = None
    return [count]