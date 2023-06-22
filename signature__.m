K = 3;
M(K) = 0;
M(1) = 2;
M(2) = 3;
M(3) = 3;
signature = zeros(M(1)+1,M(2)+1,M(3)+1);
signature(1,3,3) = 1/3;
signature(1,3,2) = 2/3;
signature(1,3,1) = 1;
signature(1,2,3) = 2/3;
signature(1,2,2) = 1;
signature(1,2,1) = 1;
signature(1,1,3) = 1;
signature(1,1,2) = 1;
signature(1,1,1) = 1;
syms tt;
P(301) = 0;
for t = 0:300
    for i = 1:M(1)+1
        for j = 1:M(2)+1
            for k = 1:M(3)+1
               F1 = 1-exp(-t/3652);
               F2 = 1-exp(-t/4383);
               F3 = (1/(sqrt(2*pi)*100)*int(exp(-(tt-2922).^2/20000),-inf,t));
               temp1 = combination_function(M(1),i-1)*(F1.^((i-1)))*((1-F1).^(M(1)-(i-1)));
               temp2 = combination_function(M(2),j-1)*(F2.^((j-1)))*((1-F2).^(M(2)-(j-1)));
               temp3 = combination_function(M(3),k-1)*(F3.^((k-1)))*((1-F3).^(M(3)-(k-1)));
               P(t+1) = signature(i,j,k)*temp1*temp2*temp3+P(t+1);
            end
        end
    end
end
plot(0:300,P);
hold on;