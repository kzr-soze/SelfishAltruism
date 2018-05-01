function [] = Delta_Spectrum(seed,rounds,delta_min,delta_max,a_dist,b_dist,n)
%Calculates the PoA for a game at 200 points between delta_min and
%delta_max, then plots it
    delta = linspace(delta_min,delta_max,200);
    trust = zeros(200);
    for k = 1:200
        trust(k) = Gameplay_LF(seed,rounds,delta(k),delta(k),a_dist,b_dist,n);
    end
    
    plot(delta,trust);
    title('PoA Limited-Trust as a function of delta')
    xlabel('delta');
    ylabel('PoA');
    legend('PoA Limited-Trust');
    

end

