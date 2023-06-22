load('failture_signature.mat');
K = 5;
M(K) = 0;
M(1) = 4;
M(2) = 5;
M(3) = 4;
M(4) = 4;
M(5) = 2;
sig_end = zeros(M(1)+1,M(2)+1,M(3)+1,M(4)+1,M(5)+1);
for n = 1:2250
    sig_end(ans(n,1),ans(n,2),ans(n,3),ans(n,4),ans(n,5))=ans(n,6);
end
for n = 1:5
    for j = 1:6
        for i = 1:5
            for k = 1:5
                for m = 1:3
                    disp(n + " "+ j + " "+i + " "+ k + " "+ m + " " + sig_end(n,j,i,k,m));
                end
            end
        end
    end
end