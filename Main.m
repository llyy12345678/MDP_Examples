%% Create Markov Decision model
% Set parameters
[StateTransitionProbability, Rewards] = ValueIterationMDP.defineParameters();

% initialize inputs
stateMDP = [0,1,2,3,4,5,6,7];
actionMDP = Action.getActionsMDP;
discount = 0.9;
epsilon = 0.01; % the maximum error for judging whether state value converges

% initialize the value state
[value,policy,delta,iterationNum]=ValueIterationMDP.updatedValue(stateMDP,actionMDP, discount, epsilon, StateTransitionProbability, Rewards);

disp([' ']);
disp(['Optimal Policy is: ']);
for i = 1:size(policy,1)
    policyName = actionMDP{policy(i,1)};
    disp(['->',policyName.name]);
end




