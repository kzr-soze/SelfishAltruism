classdef Game22 < handle
    %UNTITLED6 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        a_payoff
        b_payoff
        a_debt
        b_debt
        a_debt_limit
        b_debt_limit
        pure_equilibria
        seed
        state
        rounds
    end
    
    methods
        function game = Game22(alim,blim,seed)
            game.seed = seed;
            rng(seed);
            game.a_payoff = randi(100,2);
            game.b_payoff = randi(100,2);
            game.a_debt = 0;
            game.b_debt = 0;
            game.a_debt_limit = alim;
            game.b_debt_limit = blim;
            game.update_pure_equilibria();
            game.state = rng;
            game.rounds = 1;
        end
        
        function [score,strat] = play_SocOpt(game)
            temp = game.a_payoff+game.b_payoff;
            score = max(temp(:));
            strat = [];
            for i=1:2
                for j = 1:2
                    if score == temp(i,j)
                        strat = [strat;i,j];
                    end
                end
            end
        end
        
        
        % Players will cooperate for the social optimum as long as it
        % doesn't cause their total loss (not net loss) to go over the limit. In the event
        % of multiple optimal strategies, the first is used arbitrarily.
        function [score] = play_DebtLim(game,MN_exp_payoff,Opt_payoff,Opt_strat)
            a_opt_payoff = game.a_payoff(Opt_strat(1),Opt_strat(2));
            b_opt_payoff = game.b_payoff(Opt_strat(1),Opt_strat(2));
           % disp([a_opt_payoff-MN_exp_payoff(1),b_opt_payoff-MN_exp_payoff(2)]);
            
            % Neither player loses by not playing MNE
            if(MN_exp_payoff(1) <= a_opt_payoff && MN_exp_payoff(2) <= b_opt_payoff)
                score = Opt_payoff;
              %  disp('Played optimal');
            
            % A would gain by not playing MNE, B would lose
            elseif(MN_exp_payoff(1) < a_opt_payoff && MN_exp_payoff(2) > b_opt_payoff)
                if(game.a_debt + (MN_exp_payoff(2)-b_opt_payoff) < game.a_debt_limit)
                    score = Opt_payoff;
                    game.a_debt = game.a_debt + (MN_exp_payoff(2)-b_opt_payoff);
                    game.b_debt = game.b_debt - (a_opt_payoff-MN_exp_payoff(1));
                   % disp('Played optimal');
                else
                    score = sum(MN_exp_payoff);
                end
                
            % B would gain by not playing MNE, A would lose
            else
                if(game.b_debt + (MN_exp_payoff(1)-a_opt_payoff) < game.b_debt_limit)
                    score = Opt_payoff;
                    game.b_debt = game.b_debt + (MN_exp_payoff(1)-a_opt_payoff);
                    game.a_debt = game.a_debt - (b_opt_payoff-MN_exp_payoff(2));
                 %   disp('Played optimal');
                else
                    score = sum(MN_exp_payoff);
                end
            end
        end
                    
        
        function pure = pure_eq(game,i,j)
            if game.a_payoff(i,j) == max(game.a_payoff(:,j)) && ...
                    game.b_payoff(i,j) == max(game.b_payoff(i,:))
                pure = true;
            else
                pure = false;
            end
        end
        
        function update_pure_equilibria(game)
            game.pure_equilibria = [];
            for i=1:2
                for j = 1:2
                    if game.pure_eq(i,j)
                        game.pure_equilibria = [game.pure_equilibria;i,j];
                    end
                end
            end
        end
        
        function new_game(game)
            rng(game.state);
            game.a_payoff = randi(100,2);
            game.b_payoff = randi(100,2);
            game.state = rng;
            game.update_pure_equilibria();
            game.rounds = game.rounds + 1;
        end
        
        function summary(game)
            disp('Payoff matrix for A: ');
            disp(game.a_payoff);
            disp('Payoff matrix for B: ');
            disp(game.b_payoff);
            disp('Pure equilibria for [A,B]: ');
            disp(game.pure_equilibria);
            disp('Current debts (A,B): ');
            disp([game.a_debt,game.b_debt]);
        end
        
        function reset(game)
            game.a_debt = 0;
            game.b_debt = 0;
            game.rounds = 1;
            rng(game.seed);
            game.a_payoff = randi(100,2);
            game.b_payoff = randi(100,2);
            game.state = rng;
        end
            
            
            
        
    end
    
end

