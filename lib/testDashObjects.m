% Run this on the command window to test:
% testCase = testDashObjects;
% results = testCase.run

classdef testDashObjects < matlab.unittest.TestCase
    methods(Test)
        function htmlDivEmpty(testCase)
            actSolution = plotlyJsonEncoder(Html('Div'));
            expSolution = '[{"props": {"children": null}, "type": "Div", "namespace": "dash_html_components"}]';
            testCase.verifyEqual(actSolution,expSolution)
        end
        function htmlDivOneChildren(testCase)
            actSolution = plotlyJsonEncoder(Html('Div', {'title'}));
            expSolution = '[{"props": {"children": "title"}, "type": "Div", "namespace": "dash_html_components"}]';
            testCase.verifyEqual(actSolution,expSolution)
        end    
        function DccExplicitChildren(testCase)
            actSolution = plotlyJsonEncoder(Dcc('Tabs', {'children',{Dcc('Tab', {'label','one','value','tab1'})}}));
            expSolution = '[{"props": {"children": [{"props": {"children": null, "label": "one", "value": "tab1"}, "type": "Tab", "namespace": "dash_core_components"}]}, "type": "Tabs", "namespace": "dash_core_components"}]';
            testCase.verifyEqual(actSolution,expSolution)
        end  
        function DccImplicitChildren(testCase)
            actSolution = plotlyJsonEncoder(Dcc('Tabs', {{Dcc('Tab', {'label','one','value','tab1'})}}));
            expSolution = '[{"props": {"children": [{"props": {"children": null, "label": "one", "value": "tab1"}, "type": "Tab", "namespace": "dash_core_components"}]}, "type": "Tabs", "namespace": "dash_core_components"}]';
            testCase.verifyEqual(actSolution,expSolution)
        end         
    end
end