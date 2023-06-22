clear;
load("111.mat");
load("sub.mat");

% pm=[100,200,300];

pm=[100,200,300];

cm=[400,500,700];

cms = 15000;

% cms = 18000;

cr=120000;
% cr=135000;

K = 3;
M(K) = 0;
M(1) = 2;
M(2) = 3;
M(3) = 3;
signature = zeros(M(1)+1,M(2)+1,M(3)+1) ;
signature(1,3,3) = 1/3;
signature(1,3,2) = 2/3;
signature(1,3,1) = 1;
signature(1,2,3) = 2/3;
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
    A(i) = 1.07.^i;
    B(i) = 1.08.^i;
    C(i) = 1.09.^i;
end
P=zeros(N,2000) ;
N1=zeros(N,2000);
N2=zeros(N,2000);
N3=zeros(N,2000);
cost=zeros(N,2000);
answer = zeros(N,2000);
temp = zeros(50,2000);
temp(1,:) = failureTime(1,:);
syms tt;
ttt = 250*2^(1/2)*pi^(1/2)*erf((500000^(1/2)*(tt - 2922))/500000);
fff = 1/(sqrt(2*pi)*500);
back = double(subs(ttt,tt,-inf));
fff3 = fff*(sub-back);
% for n = 2:50
%     for t = 300:600
%         sub(n,t) = double(subs(ttt,tt,C(n-1)*t));
%     end
%     disp(n);
% end
for n = 2:50
    temp(n,:) = temp(n-1,:) + failureTime(n,:);
    for t = 1:1500
        for i = 1:M(1)+1
            for j = 1:M(2)+1
                for k =1:M(3)+1
                    F1 = 1-exp(-A(n-1)*t/1826);
                    F2 = 1-exp(-B(n-1)*t/2191);
%                     F3 = 1-exp(-B(n-1)*t/4383);
                    F3 = fff3(n,t);
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

        cost(n,t) = cost(n,t) + (1-P(n,t))*cms;

        answer(n,t) = (cost(n,t) + cr)/temp(n,t);
%         disp(t);
    end
%     disp(n);
end




