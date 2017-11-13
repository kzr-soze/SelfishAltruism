function [ p,q,ExPayoff ] = MNE2x2(A,B)
% Calculates the Mixed Nash Equilibrium of a 2x2 matrix given by A and B
    p = [0,0];
    q = [0,0];
    
    % Check for dominating strategy for A:
    if (A(1,:) >= A(2,:))
        p = [1,0];
        if (B(1,1) > B(1,2))
            q = [1,0];
        elseif (B(1,1) < B(1,2))
            q = [0,1];
        else
            q = [.5,.5];
        end
    elseif (A(1,:) <= A(2,:))
        p = [0,1];
        if (B(2,1) > B(2,2))
            q = [1,0];
        elseif (B(2,1) < B(2,2))
            q = [0,1];
        else
            q = [.5,.5];
        end
    
    elseif (p == [0,0])
        % Check for dominating strategy for B:
        if (B(:,1) >= B(:,2))
            q = [1,0];
            if (A(1,1) > A(2,1))
                p = [1,0];
            elseif (A(1,1) < A(2,1))
                p = [0,1];
            else
                p = [.5,.5];
            end
        elseif (B(:,1) <= B(:,2))
            q = [0,1];
            if (A(1,2) > A(2,2))
                p = [1,0];
            elseif (A(1,2) < A(2,2))
                p = [0,1];
            else
                p = [.5,.5];
            end
        end        
    end
    if (p == [0,0])
        p1 = (B(2,2) - B(2,1)) / (B(1,1) + B(2,2) - B(2,1) - B(1,2));
        q1 = (A(2,2) - A(1,2)) / (A(1,1) + A(2,2) - A(2,1) - A(1,2));
        p = [p1, 1-p1];
        q = [q1, 1-q1];
    end
    Exp_A = p(1)*(A(1,1)*q(1) + A(1,2)*q(2)) + p(2)*(A(2,1)*q(1) + A(2,2)*q(2));
    Exp_B = q(1)*(B(1,1)*p(1) + B(2,1)*p(2)) + q(2)*(B(1,2)*p(1) + B(2,2)*p(2));
    ExPayoff = [Exp_A,Exp_B];
    
    
end

