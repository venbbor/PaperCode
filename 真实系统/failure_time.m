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
A(50) = 0;
B(50) = 0;
C(50) = 0;
for i = 1:50
    A(i) = 1.07.^i;
    B(i) = 1.08.^i;
    C(i) = 1.09.^i;
end

% syms tt;
% 
% ttt = 250*2^(1/2)*pi^(1/2)*erf((500000^(1/2)*(tt - 1461))/500000);
% fff = 1/(sqrt(2*pi)*500);
% back = double(subs(ttt,tt,-inf));
% fff3 = fff*(sub-back);
% for n = 1:50
%     parfor t = 1:2000
%         sub(n,t) = double(subs(ttt,tt,1*t));
%     end
%     disp(n);
% end

% failureTime = zeros(50,2000);
syms x tt;
for n = 2:2
    for t = 4000:4000
        answer = 0;
        for i = 1:M(1)+1
            for j = 1:M(2)+1
                for k =1:M(3)+1
                    F1 = 1-exp(-x/1826);
                    F2 = 1-exp(-x/2191);
                    F3 = (1/(sqrt(2*pi)*500)*int(exp(-(tt-1461).^2/500000),-inf,x));
%                     F1 = 1-exp(-A(n-1)*x/1826);
%                     F2 = 1-exp(-B(n-1)*x/2191);
%                     F3 = (1/(sqrt(2*pi)*500)*int(exp(-(tt-1461).^2/500000),-inf,C(n-1)*x));
                    temp1 = combination_function(M(1),i-1)*(F1.^((i-1)))*((1-F1).^(M(1)-(i-1)));
                    temp2 = combination_function(M(2),j-1)*(F2.^((j-1)))*((1-F2).^(M(2)-(j-1)));
                    temp3 = combination_function(M(3),k-1)*(F3.^((k-1)))*((1-F3).^(M(3)-(k-1)));
                    temp = signature(i,j,k)*temp1*temp2*temp3;
                    if(temp~=sym(0))
                        answer = double(quad(matlabFunction(temp),0,t))+answer;
                    end
                end
            end
        end
        failureTime(n,t) = answer;
%         disp(t);
    end
    disp(n);
end


