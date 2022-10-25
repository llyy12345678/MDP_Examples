classdef Wait < Action
    %WAIT Summary of this class goes here
    %   Detailed explanation goes here
    
     methods (Static)
        
        function nextState = apply(state,deltaT)
            %Wait - Apply same speed and lane
            speed = state.speed;
            
            s = state.s + speed * deltaT;
            
            d = state.d;
            
            nextState = State(s,d,speed);
        end
    end
end

