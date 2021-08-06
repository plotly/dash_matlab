# -*- coding: utf-8 -*-
"""
Created on Fri Aug  6 19:23:23 2021

@author: Omar Khater
"""
import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback(stock):
    fig = json.loads(eng.callback(stock))
    plotly_fig = {'data': fig['data'], 'layout': fig['layout']}
    return [plotly_fig]