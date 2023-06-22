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
answer = zeros(1,2000);
for t = 1:2000
    answer(1,t) = cr/failureTime(1,t);
end



