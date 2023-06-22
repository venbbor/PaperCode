K = 2;
M(K) = 0;
M(1) = 3;
M(2) = 3;
signature = zeros(M(1)+1,M(2)+1);
signature(3,2) = 1/9;
signature(3,1) = 3/9;
signature(2,2) = 4/9;
signature(2,1) = 6/9;
signature(1,4) = 1;
signature(1,3) = 1;
signature(1,2) = 1;
signature(1,1) = 1;

signature1(2,3) = 1/9;
signature1(2,4) = 3/9;
signature1(3,3) = 4/9;
signature1(3,4) = 6/9;
signature1(4,1) = 1;
signature1(4,2) = 1;
signature1(4,3) = 1;
signature1(4,4) = 1;
P(31) = 0;
N(31) = 0;
for t = 0:30
    for i = 1:M(1)+1
        for j = 1:M(2)+1
            F1 = 1-exp(-(t/10)^0.5);
            F2 = 1-exp(-(t/10)^0.8);
            temp1 = combination_function(M(1),i-1)*(F1.^((i-1)))*((1-F1).^(M(1)-(i-1)));
            temp2 = combination_function(M(2),j-1)*(F2.^((j-1)))*((1-F2).^(M(2)-(j-1)));
            P(t+1) = signature(i,j)*temp1*temp2+P(t+1);
            N(t+1) = (i-1)*signature(i,j)*temp1*temp2+N(t+1);
        end  
    end
    N(t+1) = N(t+1)/P(t+1);
end
plot(0:30,P);
hold on;