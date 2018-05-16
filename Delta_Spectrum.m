function [] = Delta_Spectrum(seed,rounds,delta_min,delta_max,a_dist,b_dist,n)
%Calculates the PoA for a game at 200 points between delta_min and
%delta_max, then plots it
    clc;
    close;
    delta = linspace(delta_min,delta_max,200);
    naive_trust = zeros(200,1);
    knowledge_trust = zeros(200,1);
    drive_trust = zeros(200,1);
    for k = 1:200
        [naive_trust(k),knowledge_trust(k),drive_trust(k),sum_stack,sum_opt] = Gameplay_LF(seed,rounds,delta(k),delta(k),a_dist,b_dist,n);
    end
    
    gap = sum_opt-sum_stack;
    
    eff_naive = (100/gap).*(naive_trust-sum_stack);
    eff_knowledge = (100/gap).*(knowledge_trust-sum_stack);
    eff_drive = (100/gap).*(drive_trust-sum_stack);
    
    
    
    subplot(2,1,1);
    plot(delta,sum_opt./naive_trust,delta,sum_opt./knowledge_trust,delta,sum_opt./drive_trust);
    title(['PoA Limited-Trust on ' func2str(a_dist)])
    xlabel('delta');
    ylabel('Percent');
    legend(' Naive Limited-Trust','PoA Informed Limited-Trust','PoA Drive Trust');
    
    subplot(2,1,2);
    plot(delta,eff_naive,delta,eff_knowledge,delta, eff_drive);
    title(['Efficiency of Trust Strategies on ', func2str(a_dist) ' compared to Stackelberg']);
    xlabel('delta');
    ylabel('% of Stackelberg');
    legend('Efficiency Naive Limited-Trust','Efficiency Informed Limited-Trust','Efficiency Drive Trust');
    

end

