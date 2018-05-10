function [ soc_opt,stack,trust ] = LFENaivenxn( A,B,delta1,delta2)
% Finds the equilibrium of a leader follower game according to delta1 and
% delta2, when player 1 has no knowledge of delta2
    n = size(A,1);
    temp = A+B;
    soc_opt = max(temp(:));
    [~,best_response] = max(B,[],2); %Get p2's best response to each move
    
    stack_move1 = 1;
    stack_payoff1 = A(1,best_response(1));
    stack_payoff2 = B(1,best_response(1));
    
    BR_payoffs = zeros(n,2);
    
    for k = 1:n
        new_pay1 = A(k,best_response(k));
        new_pay2 = B(k,best_response(k));
        BR_payoffs(k,:) = [k,new_pay1+new_pay2];
        if (new_pay1 > stack_payoff1 || (new_pay1 == stack_payoff1 && new_pay2 > stack_payoff2))
            stack_move1 = k;
            stack_payoff1 = new_pay1;
            stack_payoff2 = new_pay2;
        end
    end
    
    stack_move2 = best_response(stack_move1);
    stack_payoff_total = A(stack_move1,stack_move2) + B(stack_move1,stack_move2);
    BR_payoffs = sortrows(BR_payoffs,-2);
    trust_move1 = stack_move1; % p1's move according to delta1
    count = 1;
    go = true;
    while (go && count <= n)
        move = BR_payoffs(count,1);
        payoff = A(move,best_response(move));
        if (stack_payoff1 - payoff <= delta1)
            trust_move1 = move;
            trust_payoff1 = payoff;
            go = false;
        end
        count = count+1;
    end
    
    %Construct the payoffs of p2's possible responses to p1's trusting
    % move
    
    
    net_trust = [linspace(1,n,n);B(trust_move1,:) + A(trust_move1,:)];
    net_trust = sortrows(net_trust',-2)';
    
    
    trust_move2 = best_response(trust_move1);
    trust_payoff2 = B(trust_move1,trust_move2);
    greedy_payoff2 = B(trust_move1,best_response(trust_move1));
    count = 1;
    go = true;
%     disp('Calculating 2s trust move');
%     disp(net_trust);
    while(go && count <= n)
        move = net_trust(1,count);
        payoff = B(trust_move1,move);
        
        if( greedy_payoff2 - payoff <=delta2)
            trust_move2 = move;
            trust_payoff2 = payoff;
            trust_payoff1 = A(trust_move1,move);
            go = false;
        end
        count = count+1;
    end
    
    trust_payoff_total = trust_payoff1+trust_payoff2;
    
    trust = [trust_move1,trust_move2,trust_payoff_total];
    stack = [stack_move1,stack_move2,stack_payoff_total];
    
    
    
    
    
    


end

