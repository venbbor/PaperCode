K = 3;
M(K) = 0;
M(1) = 6;
M(2) = 3;
M(3) = 2;
signature = zeros(M(1)+1,M(2)+1,M(3)+1);
signature(4,4,2) = 1/20;
signature(4,4,1) = 1/20;
signature(4,3,2) = 1/20;
signature(4,3,1) = 1/20;
signature(4,2,2) = 1/20;
signature(4,2,1) = 1/20;
signature(4,1,2) = 1/20;
signature(4,1,1) = 1/20;
signature(3,4,2) = 1/5;
signature(3,4,1) = 1/5;
signature(3,3,3) = 1/15;
signature(3,3,2) = 1/3;
signature(3,3,1) = 1/3;
signature(3,2,3) = 1/15;
signature(3,2,2) = 1/3;
signature(3,2,1) = 1/3;
signature(3,1,3) = 1/15;
signature(3,1,2) = 1/3;
signature(3,1,1) = 1/3;
signature(2,4,3) = 1/6;
signature(2,4,2) = 1/2;
signature(2,4,1) = 1/2;
signature(2,3,3) = 1/2;
signature(2,3,2) = 2/3;
signature(2,3,1) = 2/3;
signature(2,2,3) = 1/2;
signature(2,2,2) = 2/3;
signature(2,2,1) = 2/3;
signature(2,1,3) = 1/2;
signature(2,1,2) = 2/3;
signature(2,1,1) = 2/3;
signature(1,4,3) = 1;
signature(1,4,2) = 1;
signature(1,4,1) = 1;
signature(1,3,3) = 1;
signature(1,3,2) = 1;
signature(1,3,1) = 1;
signature(1,2,3) = 1;
signature(1,2,2) = 1;
signature(1,2,1) = 1;
signature(1,1,3) = 1;
signature(1,1,2) = 1;
signature(1,1,1) = 1;
A(40) = 0;
B(40) = 0;
C(40) = 0;
for i = 1:40
    A(i) = 1.03.^i;
    B(i) = 1.04.^i;
    C(i) = 1.05.^i;
end
failureTime = zeros(50,300);
syms x;
for n = 1:1
    for t = 1:300
        answer = 0;
        for i = 1:M(1)+1
            for j = 1:M(2)+1
                for k =1:M(3)+1
                    F1 = 1-exp(-(x*0.005)^1.5);
                    F2 = 1-exp(-(x*0.012)^1.8);
                    F3 = 1-exp(-(x*0.011)^1.6);
%                     F1 = 1-exp(-(A(n-1)*x/100)^1.5);
%                     F2 = 1-exp(-(B(n-1)*x/100)^1.8);
%                     F3 = 1-exp(-(C(n-1)*x/100)^1.6);
                    temp1 = combination_function(M(1),i-1)*(F1.^((i-1)))*((1-F1).^(M(1)-(i-1)));
                    temp2 = combination_function(M(2),j-1)*(F2.^((j-1)))*((1-F2).^(M(2)-(j-1)));
                    temp3 = combination_function(M(3),k-1)*(F3.^((k-1)))*((1-F3).^(M(3)-(k-1)));
                    temp = signature(i,j,k)*temp1*temp2*temp3;
                    if(temp~=sym(0))
                        answer = double(quad(matlabFunction(temp),0,t))+answer;
                    end
                end
            end
        end
        failureTime(n,t) = answer;
        disp(t);
    end
end


