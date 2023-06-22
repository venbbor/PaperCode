cd=1000;
cr=120000;
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
P=zeros(1,2000) ;
cost=zeros(1,2000);
answer = zeros(1,2000);

syms tt;
ttt = 50*2^(1/2)*pi^(1/2)*erf((20000^(1/2)*(tt - 1461))/500000);
fff = 1/(sqrt(2*pi)*500);
back = double(subs(ttt,tt,-inf));
fff3 = fff*(sub-back);

for t = 1:2000
    for i = 1:M(1)+1
        for j = 1:M(2)+1
            for k =1:M(3)+1
                F1 = 1-exp(-t/1826);
                F2 = 1-exp(-t/2191);
                F3 = fff3(1,t);
                temp1 = combination_function(M(1),i-1)*(F1.^((i-1)))*((1-F1).^(M(1)-(i-1)));
                temp2 = combination_function(M(2),j-1)*(F2.^((j-1)))*((1-F2).^(M(2)-(j-1)));
                temp3 = combination_function(M(3),k-1)*(F3.^((k-1)))*((1-F3).^(M(3)-(k-1)));
                P(1,t) = signature(i,j,k)*temp1*temp2*temp3+P(1,t);
            end
        end
    end
    cost(1,t) = (t-failureTime(1,t))*cd ;
    answer(1,t) = (cost(1,t) + cr)/t;
end



