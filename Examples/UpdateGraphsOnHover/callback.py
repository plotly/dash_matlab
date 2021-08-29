# -*- coding: utf-8 -*-
"""
Created on Wed Aug 25 23:25:59 2021

@author: Omar Khater
"""
import matlab.engine
import json

future = matlab.engine.start_matlab(background=True)
eng = future.result()

def callback(year, xaxis, yaxis,hoverData, xscale, yscale):
    
    if hoverData != None:
        country_idx = hoverData['points'][0]['pointIndex']
        figures = eng.callback(year, xaxis, yaxis, country_idx, xscale, yscale)
    else:
        # Avoid error if there is no hover 
        figures = eng.callback(year, xaxis, yaxis, 1, xscale, yscale)
        
    fig1 = json.loads(figures[0]) 
    fig2 = json.loads(figures[1])
    plotly_fig1 = {'data': fig1['data'], 'layout': fig1['layout']}
    plotly_fig2 = {'data': fig2['data'], 'layout': fig2['layout']}
    return [plotly_fig1, plotly_fig2]
    

