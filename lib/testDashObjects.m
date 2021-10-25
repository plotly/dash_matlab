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
            expSolution =  '[{"props": {"children": "title"}, "type": "Div", "namespace": "dash_html_components"}]';
            testCase.verifyEqual(actSolution,expSolution)
        end        
    end
end