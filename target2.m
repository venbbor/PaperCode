pm=[5,10,5];
cm=[15,30,15];
cms = 3000;
cr=21600;
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
N=40;
A(41) = 0;
A(1) = 1;
for r = 2:41
    A(r) = 1.05.^r;
end
P=zeros(N-1,90) ;
N1=zeros(N-1,90);
N2=zeros(N-1,90);
N3=zeros(N-1,90);
cost=zeros(N-1,90);
answer = zeros(N-1,90);
temp = failureTime(1,:);
for n = 1:N-1
    temp = temp + failureTime(n+1,:);
    for t = 1:90
        for i = 1:M(1)+1
            for j = 1:M(2)+1
                for k =1:M(3)+1
                    F1 = 1-exp(-(t/50*A(n))^1.5);
                    F2 = 1-exp(-(t/50*A(n))^1.8);
                    F3 = 1-exp(-(t/50*A(n))^1.6);
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
        cost(n,t) = cost(n,t) + pm(2)*M(1)+(cm(2)-pm(2))*N2(n,t);
        cost(n,t) = cost(n,t) + pm(3)*M(3)+(cm(1)-pm(3))*N3(n,t);
        cost(n,t) = cost(n,t)*P(n,t);
        if(n>=2)
            cost(n,t) = cost(n,t) + cost(n-1,t);
        end
        cost(n,t) = cost(n,t) + (1-P(n,t))*cms;
        answer(n,t) = (cost(n,t) + cr)/temp(1,t);
    end
end




