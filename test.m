pm=[0.05,0.02,0.03];
cm=[0.1,0.05,0.06];
cd=5;
cms = 3;
cr=100;
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
signature(5,1,3) = 1/5;
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
N=20;
A(20) = 0;
for r = 1:20
    A(r) = 1.05.^r;
end

answer = zeros(N-1,120);
P=zeros(1,101) ;

for t = 0:100
    for i = 1:M(1)+1
        for j = 1:M(2)+1
            for k =1:M(3)+1
                F1 = 1-exp(-(t/50)^1.5);
                F2 = 1-exp(-(t/50)^1.8);
                F3 = 1-exp(-(t/50)^1.6);
                temp1 = combination_function(M(1),i-1)*(F1.^(M(1)-(i-1)))*((1-F1).^((i-1)));
                temp2 = combination_function(M(2),j-1)*(F2.^(M(2)-(j-1)))*((1-F2).^((j-1)));
                temp3 = combination_function(M(3),k-1)*(F3.^(M(3)-(k-1)))*((1-F3).^((k-1)));
                P(t+1) = signature(i,j,k)*temp1*temp2*temp3+P(t+1);
%                 P(t+1) = ((i-1)-M(1)*(1-F1))/((1-F1)*F1)*signature(i,j,k)*temp1*temp2*temp3+P(t+1);
%                 P(t+1) = ((j-1)-M(2)*(1-F2))/((1-F2)*F2)*signature(i,j,k)*temp1*temp2*temp3+P(t+1);
%                 P(t+1) = ((k-1)-M(3)*(1-F3))/((1-F3)*F3)*signature(i,j,k)*temp1*temp2*temp3+P(t+1);
            end
        end
    end
end

plot(0:100,P,'k-','LineWidth',1.2);
hold on;
xlabel('时间t');
ylabel('系统可靠性');


