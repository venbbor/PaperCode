Step = 5;     %人工鱼的移动最大步长
N = 5;         %人工鱼的数量
dim=1;          %人工鱼维度  
yub=100;%边界上限
ylb=1;%边界下限

d = [];
Iteration = 1; %
Max_iteration = 50;%迭代次数
%初始化人工鱼种群
x(N,dim) = zeros;
x(:,1)=ylb+rand(N,1).*(yub-ylb);
x=round(x,0);
%计算10个初始状态下的适应度值；
for i = 1:N
    fitness_fish(i) = answer(1,x(i,1));
end
[best_fitness,I] = min(fitness_fish);         % 求出初始状态下的最优适应度；
best_x = x(I,:);             % 最优人工鱼；
while Iteration<=100000
    step = Step/(floor(Iteration/10)+1);
    for i = 1:N
        fitness_follow = inf;
        for j = 1:N
            if (answer(1,x(j,1))<fitness_follow)
                best_pos = x(j,1);
                fitness_follow = answer(1,x(j,1));
            end
        end
        y_follow = x(i,1)+rand*step.*(best_pos-x(i,1))./norm(best_pos(1,1)-x(i,1));
        y_follow=round(y_follow,0);
        %边界判定
        if(y_follow<1)
            y_follow = 1;
        end
        if(y_follow>100)
            y_follow = 100;
        end
    end
    %% 更新信息
    for i = 1:N
        if (answer(1,x(i,1))<=best_fitness)
            best_fitness = answer(1,x(i,1));
            best_y = x(i,1);
        end
    end
%     /////////////////
    Convergence_curve(Iteration)=best_fitness;
    Iteration = Iteration+1;
    if mod(Iteration,50)==0
        display(['迭代次数：',num2str(Iteration),'最优适应度：',num2str(best_fitness)]);
        display(['最优人工鱼：',num2str(best_x)]);
    end
    if(best_y-1<1)
        best_y = 2;
    end
    if(best_y+1>100)
        best_y = 99;
    end
    if(answer(1,best_y-1)>best_fitness&&answer(1,best_y+1)>best_fitness)
        break;
    end
    for i = 1:N
        y_follow1 = x(i,1)-step;
        y_follow1=round(y_follow1,0);
        if(y_follow1<1)
                y_follow1 = 1;
        end
        if(y_follow1>100)
            y_follow1 = 100;
        end
        y_follow2 = x(i,1)+step;
        y_follow2=round(y_follow2,0);
        if(y_follow2<1)
                y_follow2 = 1;
        end
        if(y_follow2>100)
            y_follow2 = 100;
        end
        if(answer(1,y_follow1)<answer(1,y_follow2))
            x(i,1) = y_follow1;
        else
             x(i,1) = y_follow2;
        end
    end

end

semilogy(Convergence_curve,'Color','k','LineWidth',1.2)
xlabel('Iteration');
ylabel('best_fitness');
axis tight
grid off
box on