function [] = Delta_Spectrum(seed,rounds,delta_min,delta_max,a_dist,b_dist,n)
%Calculates the PoA for a game at 200 points between delta_min and
%delta_max, then plots it
    clc;
    close;
    delta = linspace(delta_min,delta_max,200);
    naive_trust = zeros(200,1);
    knowledge_trust = zeros(200,1);
    for k = 1:200
        [naive_trust(k),knowledge_trust(k)] = Gameplay_LF(seed,rounds,delta(k),delta(k),a_dist,b_dist,n);
    end
    disp(naive_trust);
    
    plot(delta,naive_trust,delta,knowledge_trust);
    title('PoA Limited-Trust as a function of delta')
    xlabel('delta');
    ylabel('PoA');
    legend('PoA Naive Limited-Trust','PoA Informed Limited-Trust');
    

end

