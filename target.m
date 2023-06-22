pm=[1,2,3];
cm=[3,6,5];
cd=100;
cms = 400;
cr=7000;
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
N=50;
A(50) = 0;
B(50) = 0;
C(50) = 0;
A(1) = 1;
B(1) = 1;
C(1) = 1;
for i = 2:50
    A(i) = 1.03.^(i-1);
    B(i) = 1.04.^(i-1);
    C(i) = 1.05.^(i-1);
end
P=zeros(N,100) ;
N1=zeros(N,100);
N2=zeros(N,100);
N3=zeros(N,100);
cost=zeros(N,100);
answer = zeros(N,100);
answer(1,:) = +inf;
for n = 2:N
    for t = 1:100
        for i = 1:M(1)+1
            for j = 1:M(2)+1
                for k =1:M(3)+1
                    F1 = 1-exp(-(A(n-1)*t/100)^1.5);
                    F2 = 1-exp(-(B(n-1)*t/100)^1.8);
                    F3 = 1-exp(-(C(n-1)*t/100)^1.6);
                    temp1 = combination_function(M(1),i-1)*(F1.^((i-1)))*((1-F1).^(M(1)-(i-1)));
                    temp2 = combination_function(M(2),j-1)*(F2.^((j-1)))*((1-F2).^(M(2)-(j-1)));
                    temp3 = combination_function(M(3),k-1)*(F3.^((k-1)))*((1-F3).^(M(3)-(k-1)));
                    P(n,t) = signature(i,j,k)*temp1*temp2*temp3+P(n,t);
                    N1(n,t) = (i-1)*signature(i,j,k)*temp1*temp2*temp3+N1(n,t);
                    N2(n,t) = (j-1)*signature(i,j,k)*temp1*temp2*temp3+N2(n,t);
                    N3(n,t) = (k-1)*signature(i,j,k)*temp1*temp2*temp3+N3(n,t);
                end
            end
        end
        N1(n,t) = N1(n,t)/P(n,t);
        N2(n,t) = N2(n,t)/P(n,t);
        N3(n,t) = N3(n,t)/P(n,t);
        cost(n,t) = cost(n,t) + pm(1)*M(1)+(cm(1)-pm(1))*N1(n,t);
        cost(n,t) = cost(n,t) + pm(2)*M(2)+(cm(2)-pm(2))*N2(n,t);
        cost(n,t) = cost(n,t) + pm(3)*M(3)+(cm(3)-pm(3))*N3(n,t);
        cost(n,t) = cost(n,t)*P(n,t);

        cost(n,t) = cost(n,t) + cost(n-1,t);

        cost(n,t) = cost(n,t) + (1-P(n,t))*((t-failureTime(n-1,t))*cd + cms);
        cost(n,t) = cost(n,t) + (t-failureTime(n,t))*cd;
        answer(n,t) = (cost(n,t) + cr)/(n*t);
    end
end


