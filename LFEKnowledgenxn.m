function [ soc_opt,trust ] = LFEKnowledgenxn(  A,B,delta1,delta2 )
% Finds the equilibrium of a leader follower game according to delta1 and
% delta2, when player 1 knows and accounts for delta2

    n = size(A,1);
    temp = A+B;
    soc_opt = max(temp(:));
    [~,best_response] = max(B,[],2); %Get p2's best response to each move
    [delta_responses,soc_payoff] = Delta_eval(A,B,delta2,best_response);
    
    greedy = -(10^10);
    greedy_move = -1;
    for i = 1:n
        if(greedy < A(i,delta_responses(i)))
            greedy = A(i,delta_responses(i));
            greedy_move = i;
        end
    end
    
    best = greedy + B(greedy_move,delta_responses(greedy_move));
    move1 = greedy_move;
    
    for i = 1:n
        respi = A(i,delta_responses(i));
        soci = soc_payoff(i);
        if(soci > best && (greedy - respi < delta1))
            best = soci;
            move1 = greedy_move;
        end
    end
    
    trust = [move1,delta_responses(move1),best];


end

