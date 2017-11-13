function [scores] = Gameplay(seed,rounds,alim,blim)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
    g = Game22(alim,blim,seed);
    scores = zeros(rounds,3);
    [p,q,exp] = MNE2x2(g.a_payoff,g.b_payoff);
    [sc,strat] = g.play_SocOpt();
    sc2 = g.play_DebtLim(exp,sc,strat);
    scores(1,1) = sc;
    scores(1,2) = sum(exp);
    scores(1,3) = sc2;
    for r = 2:rounds
        g.new_game();
        [p,q,exp] = MNE2x2(g.a_payoff,g.b_payoff);
        [sc,strat] = g.play_SocOpt();
        sc2 = g.play_DebtLim(exp,sc,strat);
        scores(r,1) = sc + scores(r-1,1);
        scores(r,2) = sum(exp) + scores(r-1,2);
        scores(r,3) = sc2 + scores(r-1,3);
%         scores(r,1) = sc;
%         scores(r,2) = sum(exp);
%         scores(r,3) = sc2;
    end
    g.summary()
    
    

end

