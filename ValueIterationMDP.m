classdef ValueIterationMDP
    %VALUEITERATIONMDP Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Static)
        
        function [StateTransitionProbability, Rewards] = defineParameters()
            %VALUEITERATIONMDP Construct an instance of this class
            %   Detailed explanation goes here
            
            %% Define the state transition Probability
            % action choose "Gas", the state transition probability
            pGas =   [0.1,0.9,  0,  0,  0,  0,  0,  0;
                        0,0.1,0.9,  0,  0,  0,  0,  0;
                        0,  0,0.1,0.9,  0,  0,  0,  0;
                        0,  0,  0,0.1,0.9,  0,  0,  0;
                        0,  0,  0,  0,0.1,0.9,  0,  0;
                        0,  0,  0,  0,  0,0.1,0.9,  0;
                        0,  0,  0,  0,  0,  0,0.1,0.9;
                        0,  0,  0,  0,  0,  0,  0,  0];
            % action choose "Wait", the state transition probability
            pWait =  [0.8,0.2,  0,  0,  0,  0,  0,  0;
                        0,0.8,0.2,  0,  0,  0,  0,  0;
                        0,  0,0.8,0.2,  0,  0,  0,  0;
                        0,  0,  0,0.8,0.2,  0,  0,  0;
                        0,  0,  0,  0,0.8,0.2,  0,  0;
                        0,  0,  0,  0,  0,0.8,0.2,  0;
                        0,  0,  0,  0,  0,  0,0.8,0.2;
                        0,  0,  0,  0,  0,  0,  0,  0];
            
            
            P(:,:,1) = pGas;
            P(:,:,2) = pWait;
            
            StateTransitionProbability = P; % (SxSxA)
            
            %% Define the rewards matrix
            rGas = transpose([2, 2, 2, 2, 2, 2, 2, 12]);
            rWait =transpose([0, 0, 0, 0, 0, 0, 0, 10]) ;
%             rWait =transpose([1, 1, 1, 1, 1, 1, 1, 10]) ;
            
            R(:,:,1) = rGas;
            R(:,:,2) = rWait;
            Rewards = R; % (Sx1xA)
            
        end
        
        function [value,policy,delta,iterationNum]= updatedValue(state, action, discount, epsilon, StateTransitionProbability, Rewards)
            P = StateTransitionProbability;
            d = discount;
            
            actionNum = length(action);
            for a = 1:actionNum
                R(:,a) = sum(P(:,:,a).*Rewards(:,:,a),2); % rewards matrix
            end
            
            
            flag = true;
            nextValue = zeros(length(state),1);
            iterationNum = 0;
            
            while flag
                value = nextValue;
                delta = 0; % the difference between the new value and the previous value after one iteration
                
                for a = 1:actionNum
                    valueAllActions(:,a) = R(:,a) + d*P(:,:,a)*value;
                end
                
                [nextValue, policy] = max(valueAllActions,[],2); % maximum value taking different actions
                
                valueDifference = abs(max(nextValue-value));
                if valueDifference > delta
                    delta = valueDifference;
                else
                    delta = delta;
                end
                
                if (delta < epsilon)
                    flag = false;
                end
                iterationNum = iterationNum + 1;
                
            end
            
        end
        
        
    end
end

