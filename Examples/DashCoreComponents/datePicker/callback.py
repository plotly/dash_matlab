import matlab.engine
import json
from datetime import date

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback(date_def):
    if date_def is not None:
        date_object = json.loads(eng.callback(date_def))
        date_object = date.fromisoformat(date_object[:10])
        date_object = date_object.strftime('%B %d, %Y')
        date_msg = 'You have selected: ' + date_object

        return [date_msg]
