function y = combination_function(upper,low)
y = 1;
temp = 1;
for i = 1:low
    y = (upper-i+1)*y;
    temp = i*temp;
end
y = y/temp;



