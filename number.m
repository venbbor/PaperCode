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

P(200) = 0;
N1(200)= 0;
N2(200)= 0;
N3(200)= 0;
for t = 1:200
    for i = 1:M(1)+1
        for j = 1:M(2)+1
            for k =1:M(3)+1
                F1 = 1-exp(-(t/50)^1.5);
                F2 = 1-exp(-(t/50)^1.8);
                F3 = 1-exp(-(t/50)^1.7);
                temp1 = combination_function(M(1),i-1)*(F1.^((i-1)))*((1-F1).^(M(1)-(i-1)));
                temp2 = combination_function(M(2),j-1)*(F2.^((j-1)))*((1-F2).^(M(2)-(j-1)));
                temp3 = combination_function(M(3),k-1)*(F3.^((k-1)))*((1-F3).^(M(3)-(k-1)));
                P(t) = signature(i,j,k)*temp1*temp2*temp3+P(t);
                N1(t) = (i-1)*signature(i,j,k)*temp1*temp2*temp3+N1(t);
                N2(t) = (j-1)*signature(i,j,k)*temp1*temp2*temp3+N2(t);
                N3(t) = (k-1)*signature(i,j,k)*temp1*temp2*temp3+N3(t);
            end
        end
    end
    N1(t) = N1(t)/P(t);
    N2(t) = N2(t)/P(t);
    N3(t) = N3(t)/P(t);
end

plot(1:200,P);
hold on;


