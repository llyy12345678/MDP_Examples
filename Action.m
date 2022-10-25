classdef Action
    %MANEUVER = Superclass for all maneuvers
    
    properties
        name
    end
    
    methods
        function obj = Action(name)
            %MANEUVER Construct an instance of this class
            %   Detailed explanation goes here
            obj.name = name;
        end
       
        
    end
    
    methods (Static)
        
        function actionsMDP = getActionsMDP()
            actionsMDP = {Gas('Gas'),Wait('Wait')};
        end
        
    end
    
    
    
    methods (Abstract)
        apply(obj)
    end
end

