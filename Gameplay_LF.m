function [trust,stack] = Gameplay_LF(seed,rounds,delta1,delta2,a_dist,b_dist,n)
% Plays the leader follower version of the game 
  %  clc;
    rng(seed);
    sum_opt = 0;
    sum_stack = 0;
    sum_trust = 0;
    trust_opt_played = 0;
    stack_opt_played = 0;
    poa_trust = zeros(rounds,1);
    poa_stack = zeros(rounds,1);
    for k = 1:rounds
        A = a_dist(n);
        B = b_dist(n);
        [opt,stack,trust] = LFEnxn(A,B,delta1,delta2);
%         disp(A);
%         disp(B);
        sum_opt = sum_opt + opt;
        sum_trust = sum_trust + trust(3);
        sum_stack = sum_stack + stack(3);
        if(opt == trust(3))
            trust_opt_played = trust_opt_played+1;
        end
        if(opt == stack(3))
            stack_opt_played = stack_opt_played+1;
%             disp(stack);
%             disp(A);
%             disp(B);
        end
        poa_trust(k) = sum_opt/sum_trust;
        poa_stack(k) = sum_opt/sum_stack;
    end
%     x = linspace(1,rounds,rounds);
%     plot(x,poa_trust,x,poa_stack);
%     title(['PoA for Limited-Trust and Zero-Trust Leader-Follower ',num2str(rounds),' round game'])
%     xlabel('Rounds');
%     ylabel('PoA');
%     legend('PoA Limited-Trust','PoA Zero-Trust');
%     disp(['Probability of playing optimum, Zero-Trust: ',num2str(stack_opt_played/rounds)]);
%     disp(['Probability of playing optimum, Limited-Trust: ',num2str(trust_opt_played/rounds)]);
%     disp(['Approximate PoA of Zero-Trust: ',num2str(max(poa_stack(rounds),poa_stack(rounds)^-1))]);
%     disp(['Approximate PoA of Limited-Trust: ',num2str(max(poa_trust(rounds),poa_trust(rounds)^-1))]);
%     
    stack = (max(poa_stack(rounds),poa_stack(rounds)^-1));
    trust = (max(poa_trust(rounds),poa_trust(rounds)^-1));

end

