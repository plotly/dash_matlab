# -*- coding: utf-8 -*-
"""
Created on Fri Aug 20 23:10:30 2021

@author: Omar Khater
"""

import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback(hoverData, clickData, selectedData, relayoutData):
    return([json.dumps(hoverData), json.dumps(clickData), 
            json.dumps(selectedData), json.dumps(relayoutData)])
    
    
    