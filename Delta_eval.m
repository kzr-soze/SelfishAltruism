function [delta_responses, soc_payoff] = Delta_eval(A,B,delta2,best_responses)
    
    n = size(A,1);
    delta_responses = zeros(n,1);
    soc_payoff = zeros(n,1);
    for i=1:n
        greedy2 = B(i,best_responses(i)); % Best 2 can do if 1 plays i
        best2 = greedy2 + A(i,best_responses(i));
        delta_responses(i) = best_responses(i);
        for j = 1:n
           respj = B(i,j);
           socj = respj + A(i,j);
           
           % Check if responding with j creates the best social outcome
           % subject to delta2
           if (socj > best2 && (greedy2 - respj < delta2))
               delta_responses(i) = j;
               best2 = socj;
           end
            
        end
        soc_payoff(i,1) = best2;
        
    end


end

