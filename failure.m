K = 3;
M(K) = 0;
M(1) = 6;
M(2) = 3;
M(3) = 2;
signature = zeros(M(1)+1,M(2)+1,M(3)+1);
signature(4,1,2) = 1/20;
signature(4,1,3) = 1/20;
signature(4,2,2) = 1/20;
signature(4,2,3) = 1/20;
signature(4,3,2) = 1/20;
signature(4,3,3) = 1/20;
signature(4,4,2) = 1/20;
signature(4,4,3) = 1/20;
signature(5,1,2) = 1/5;
signature(4,1,3) = 1/5;
signature(5,2,1) = 1/15;
signature(5,2,2) = 1/3;
signature(5,2,3) = 1/3;
signature(5,3,1) = 1/15;
signature(5,3,2) = 1/3;
signature(5,3,3) = 1/3;
signature(5,4,1) = 1/15;
signature(5,4,2) = 1/3;
signature(5,4,3) = 1/3;
signature(6,1,1) = 1/6;
signature(6,1,2) = 1/2;
signature(6,1,3) = 1/2;
signature(6,2,1) = 1/2;
signature(6,2,2) = 2/3;
signature(6,2,3) = 2/3;
signature(6,3,1) = 1/2;
signature(6,3,2) = 2/3;
signature(6,3,3) = 2/3;
signature(6,4,1) = 1/2;
signature(6,4,2) = 2/3;
signature(6,4,3) = 2/3;
signature(7,1,1) = 1;
signature(7,1,2) = 1;
signature(7,1,3) = 1;
signature(7,2,1) = 1;
signature(7,2,2) = 1;
signature(7,2,3) = 1;
signature(7,3,1) = 1;
signature(7,3,2) = 1;
signature(7,3,3) = 1;
signature(7,4,1) = 1;
signature(7,4,2) = 1;
signature(7,4,3) = 1;
A(50) = 0;
B(50) = 0;
C(50) = 0;
for i = 1:50
    A(i) = 1.03.^i;
    B(i) = 1.04.^i;
    C(i) = 1.05.^i;
end
P(201) = 0;
for t = 0:200
    for i = 1:M(1)+1
        for j = 1:M(2)+1
            for k =1:M(3)+1
                F1 = 1-exp(-(A(50)*t/100)^1.5);
                F2 = 1-exp(-(B(50)*t/100)^1.8);
                F3 = 1-exp(-(C(50)*t/100)^1.6);
%                 F1 = 1-exp(-(t/100)^1.5);
%                 F2 = 1-exp(-(t/100)^1.8);
%                 F3 = 1-exp(-(t/100)^1.6);
                temp1 = combination_function(M(1),i-1)*(F1.^(M(1)-(i-1)))*((1-F1).^((i-1)));
                temp2 = combination_function(M(2),j-1)*(F2.^(M(2)-(j-1)))*((1-F2).^((j-1)));
                temp3 = combination_function(M(3),k-1)*(F3.^(M(3)-(k-1)))*((1-F3).^((k-1)));
                P(t+1) = signature(i,j,k)*temp1*temp2*temp3+P(t+1);
            end
        end
    end
end
plot(0:200,P,'k','LineWidth',1.2);
hold on;
