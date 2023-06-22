load('sig_end.mat');
K = 5;
M = [4,5,4,4,2];
A(50) = 0;
B(50) = 0;
C(50) = 0;
D(50) = 0;
E(50) = 0;
for i = 1:50
    A(i) = 1.03.^i;
    B(i) = 1.04.^i;
    C(i) = 1.05.^i;
    D(i) = 1.06.^i;
    E(i) = 1.07.^i;
end
failureTime = zeros(1,1000);
syms x;
for n = 1:1
    for t = 500:800
        answer = 0;
        for i = 1:M(1)+1
            for j = 1:M(2)+1
                for k =1:M(3)+1
                    for l = 1:M(4)+1
                        for m = 1:M(5)+1
                            F1 = 1-exp(-(x*0.001)^1.5);
                            F2 = 1-exp(-(x*0.0012)^1.8);
                            F3 = 1-exp(-(x*0.0015)^1.6);
                            F4 = 1-exp(-(x*0.0012)^1.7);
                            F5 = 1-exp(-(x*0.0013)^1.9);
%                             F1 = 1-exp(-(A(n-1)*x*0.01)^1.5);
%                             F2 = 1-exp(-(B(n-1)*x*0.012)^1.8);
%                             F3 = 1-exp(-(C(n-1)*x*0.015)^1.6);
%                             F4 = 1-exp(-(D(n-1)*x*0.012)^1.7);
%                             F5 = 1-exp(-(E(n-1)*x*0.013)^1.9);
                            temp1 = combination_function(M(1),i-1)*(F1.^((i-1)))*((1-F1).^(M(1)-(i-1)));
                            temp2 = combination_function(M(2),j-1)*(F2.^((j-1)))*((1-F2).^(M(2)-(j-1)));
                            temp3 = combination_function(M(3),k-1)*(F3.^((k-1)))*((1-F3).^(M(3)-(k-1)));
                            temp4 = combination_function(M(4),l-1)*(F4.^((l-1)))*((1-F4).^(M(4)-(l-1)));
                            temp5 = combination_function(M(5),m-1)*(F5.^((m-1)))*((1-F5).^(M(5)-(m-1)));
                            temp = sig_end(i,j,k,l,m)*temp1*temp2*temp3*temp4*temp5;
                            if(temp~=sym(0))
                                answer = double(quad(matlabFunction(temp),0,t))+answer;
                            end
                        end
                    end
                end
            end
        end
%         failureTime(n,t) = answer;
%         disp(t);
    end
end


