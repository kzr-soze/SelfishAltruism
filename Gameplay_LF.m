function [sum_naive,sum_knowledge,sum_drive,sum_stack,sum_opt] = Gameplay_LF(seed,rounds,delta1,delta2,a_dist,b_dist,n)
% Plays the leader follower version of the game 
  %  clc;
    rng(seed);
    sum_opt = 0;
    sum_stack = 0;
    sum_naive = 0;
    sum_knowledge = 0;
    sum_drive = 0;
    naive_trust_opt_played = 0;
    knowledge_trust_opt_played = 0;
    stack_opt_played = 0;
    drive_opt_played = 0;
    
    poa_naive_trust = zeros(rounds,1);
    poa_knowledge_trust = zeros(rounds,1);
    poa_stack = zeros(rounds,1);
    poa_drive = zeros(rounds,1);
    for k = 1:rounds
        A = a_dist(n);
        B = b_dist(n);
        [opt,stack,naive_trust,drive_trust] = LFENaivenxn(A,B,delta1,delta2);
        [~,knowledge_trust] = LFEKnowledgenxn(A,B,delta1,delta2);
%         disp(A);
%         disp(B);
        sum_opt = sum_opt + opt;
        sum_naive = sum_naive + naive_trust(3);
        sum_stack = sum_stack + stack(3);
        sum_knowledge = sum_knowledge + knowledge_trust(3);
        sum_drive = sum_drive + drive_trust(3);
        if(opt == naive_trust(3))
            naive_trust_opt_played = naive_trust_opt_played+1;
        end
        if(opt == stack(3))
            stack_opt_played = stack_opt_played+1;
%             disp(stack);
%             disp(A);
%             disp(B);
        end
        if(opt == knowledge_trust(3))
            knowledge_trust_opt_played = knowledge_trust_opt_played + 1;
        end
        if(opt == drive_trust(3))
            drive_opt_played = drive_opt_played+1;
        end
        poa_naive_trust(k) = sum_naive/sum_stack;
        poa_stack(k) = sum_stack/sum_stack;
        poa_knowledge_trust(k) = sum_knowledge/sum_stack;
        poa_drive(k) = sum_drive/sum_stack;
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
    stack_fin = (max(poa_stack(rounds),poa_stack(rounds)^-1));
    naive_fin = (max(poa_naive_trust(rounds),poa_naive_trust(rounds)^-1));
    knowledge_fin = (max(poa_knowledge_trust(rounds),poa_knowledge_trust(rounds)^-1));
    drive_fin = (max(poa_drive(rounds),poa_drive(rounds)^-1));

end

