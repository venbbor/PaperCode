%sum(sin(x)./x) 极小值
clear;
load('真是系统策略二二答案.mat')
Visual = 3;   %人工鱼的感知距离
Step = 4;     %人工鱼的移动最大步长
N = 30;         %人工鱼的数量
dim=2;          %人工鱼维度
Try_number = 4;%迭代的最大次数
delta=5;     %拥挤度因子

%测试函数
% f=@(x) sum(x.^2);
xub=49;%边界上限
xlb=1;%边界下限

yub=2000;%边界上限
ylb=1;%边界下限

d = [];%存储50个状态下的目标函数值;
Iteration = 1; %
Max_iteration = 200;%迭代次数

%初始化人工鱼种群
xx(2*N,dim) = zeros;
xx(1:N,1)=xlb+rand(N,1).*(xub-xlb);
xx(1:N,2)=ylb+rand(N,1).*(yub-ylb);
xx(N+1:2*N,1) = 50-xx(N,1);
xx(N+1:2*N,2) = 2001-xx(N,2);
xx=round(xx,0);
%计算10个初始状态下的适应度值；
for i = 1:2*N
    fitness_fish(i) = answer(xx(i,1),xx(i,2));
end
[fitness_fish,tttt] = sort(fitness_fish);
for i = 1:N
    x(i,:) = xx(tttt(i),:);
end
[best_fitness,I] = min(fitness_fish);         % 求出初始状态下的最优适应度；
best_x = x(1,:);             % 最优人工鱼；

label = 0;

while Iteration<=Max_iteration
    if(mod(Iteration,10)==0)
        Step = Step-1;
        if(Step <= 0)
            Step=1;
        end
    end
    for i = 1:N
        %% 聚群行为
        nf_swarm=0;
        Xc=0;
        label_swarm =0;  %群聚行为发生标志
        %确定视野范围内的伙伴数目与中心位置
        for j = 1:N
            if norm(x(j,:)-x(i,:))<Visual
                nf_swarm = nf_swarm+1;  %统计在感知范围内的鱼数量
                Xc = Xc+x(j,:);       %将感知范围内的鱼进行累加
            end
        end
        Xc=Xc-x(i,:);   %需要去除本身；因为在 一开始计算时，i=j，把中心的鱼也进行了一次计算
        nf_swarm=nf_swarm-1;
        Xc = Xc/nf_swarm; %此时Xc表示视野范围其他伙伴的中心位置；
        Xc = round(Xc,0);
        %判断中心位置是否拥挤
        if  (nf_swarm~=0 && answer(Xc(1,1),Xc(1,2))/nf_swarm < delta*answer(x(i,1),x(i,2)))...
            && (answer(Xc(1,1),Xc(1,2))<answer(x(i,1),x(i,2)) ...
            && Xc(1,1)~=x(i,1)&& Xc(1,2)~=x(i,2) )
            x_swarm=x(i,1)+rand*Step.*(Xc(1,1)-x(i,1))./norm(Xc(1,1)-x(i,1));
            x_swarm=round(x_swarm,0);
            y_swarm=x(i,2)+rand*Step.*(Xc(1,2)-x(i,2))./norm(Xc(1,2)-x(i,2));
            y_swarm=round(y_swarm,0);
            %边界处理
            xub_flag=x_swarm>xub;
            xlb_flag=x_swarm<xlb;
            yub_flag=y_swarm>yub;
            ylb_flag=y_swarm<ylb;

            x_swarm=(x_swarm.*(~(xub_flag+xlb_flag)))+xub.*xub_flag+xlb.*xlb_flag;
            y_swarm=(y_swarm.*(~(yub_flag+ylb_flag)))+yub.*yub_flag+ylb.*ylb_flag;

            swarm_fitness=answer(x_swarm,y_swarm);
        else
            %觅食行为
            label_prey =0;    %判断觅食行为是否找到优于当前的状态
            for j = 1:Try_number
                %随机搜索一个状态
                x_prey_rand = x(i,1)+Visual.*(-1+2.*rand);
                x_prey_rand=round(x_prey_rand,0);
                y_prey_rand = x(i,2)+Visual.*(-1+2.*rand);
                y_prey_rand=round(y_prey_rand,0);
                xub_flag2=x_prey_rand>xub;
                xlb_flag2=x_prey_rand<xlb;

                yub_flag2=y_prey_rand>yub;
                ylb_flag2=y_prey_rand<ylb;

                x_prey_rand=(x_prey_rand.*(~(xub_flag2+xlb_flag2)))+xub.*xub_flag2+xlb.*xlb_flag2;
                y_prey_rand=(y_prey_rand.*(~(yub_flag2+ylb_flag2)))+yub.*yub_flag2+ylb.*ylb_flag2;
                %判断搜索到的状态是否比原来的好
                if answer(x(i,1),x(i,2))>answer(x_prey_rand,y_prey_rand) ...
                    && x_prey_rand~=x(i,1)&& y_prey_rand~=x(i,2)
                    x_swarm = x(i,1)+rand*Step.*(x_prey_rand-x(i,1))./norm(x_prey_rand-x(i,1));
                    x_swarm=round(x_swarm,0);
                    y_swarm = x(i,2)+rand*Step.*(y_prey_rand-x(i,2))./norm(y_prey_rand-x(i,2));
                    y_swarm=round(y_swarm,0);
                    xub_flag2=x_swarm>xub;
                    xlb_flag2=x_swarm<xlb;
                    yub_flag2=y_swarm>yub;
                    ylb_flag2=y_swarm<ylb;
                    x_swarm=(x_swarm.*(~(xub_flag2+xlb_flag2)))+xub.*xub_flag2+xlb.*xlb_flag2;
                    y_swarm=(y_swarm.*(~(yub_flag2+ylb_flag2)))+yub.*yub_flag2+ylb.*ylb_flag2;
                    swarm_fitness=answer(x_swarm,y_swarm);
                    label_prey =1;
                    break;
                end
            end
            %随机行为
            if label_prey==0
                x_swarm = x(i,1)+Step*(-1+2*rand);
                x_swarm=round(x_swarm,0);
                y_swarm = x(i,2)+Step*(-1+2*rand);
                y_swarm=round(y_swarm,0);
                xub_flag2=x_swarm>xub;
                xlb_flag2=x_swarm<xlb;
                yub_flag2=y_swarm>yub;
                ylb_flag2=y_swarm<ylb;
                x_swarm=(x_swarm.*(~(xub_flag2+xlb_flag2)))+xub.*xub_flag2+xlb.*xlb_flag2;
                y_swarm=(y_swarm.*(~(yub_flag2+ylb_flag2)))+yub.*yub_flag2+ylb.*ylb_flag2;
                swarm_fitness=answer(x_swarm,y_swarm);
            end
        end

        %% 追尾行为
        fitness_follow = inf;
        label_follow =0;%追尾行为发生标记
        %搜索人工鱼Xi视野范围内的最高适应度个体Xj
        for j = 1:N
            if (norm(x(j,:)-x(i,:))<Visual) && (answer(x(j,1),x(j,2))<fitness_follow)
                best_pos = x(j,:);
                fitness_follow = answer(x(j,1),x(j,2));
            end
        end
        %搜索人工鱼Xj视野范围内的伙伴数量
        nf_follow=0;
        for j = 1:N
            if norm(x(j,:)-best_pos)<Visual
                nf_follow=nf_follow+1;
            end
        end
        nf_follow=nf_follow-1;%去掉他本身
        %判断人工鱼Xj位置是否拥挤
        if (fitness_follow/nf_follow)<delta*answer(x(i,1),x(i,2)) ...
            && (fitness_follow<answer(x(i,1),x(i,2)))...
            && best_pos(1,1)~=x(i,1)&& best_pos(1,2)~=x(i,2)
            x_follow = x(i,1)+rand*Step.*(best_pos(1,1)-x(i,1))./norm(best_pos(1,1)-x(i,1));
            x_follow=round(x_follow,0);
            y_follow = x(i,2)+rand*Step.*(best_pos(1,2)-x(i,2))./norm(best_pos(1,2)-x(i,2));
            y_follow=round(y_follow,0);
            %边界判定
            xub_flag2=x_follow>xub;
            xlb_flag2=x_follow<xlb;
            yub_flag2=y_follow>yub;
            ylb_flag2=y_follow<ylb;
            x_follow=(x_follow.*(~(xub_flag2+xlb_flag2)))+xub.*xub_flag2+xlb.*xlb_flag2;
            y_follow=(y_follow.*(~(yub_flag2+ylb_flag2)))+yub.*yub_flag2+ylb.*ylb_flag2;
            label_follow =1;
            follow_fitness=answer(x_follow,y_follow);
        else
            %觅食行为
            label_prey =0;    %判断觅食行为是否找到优于当前的状态
            for j = 1:Try_number
                %随机搜索一个状态
                x_prey_rand = x(i,1)+Visual.*(-1+2.*rand);
                x_prey_rand=round(x_prey_rand,0);
                y_prey_rand = x(i,2)+Visual.*(-1+2.*rand);
                y_prey_rand=round(y_prey_rand,0);
                xub_flag2=x_prey_rand>xub;
                xlb_flag2=x_prey_rand<xlb;

                yub_flag2=y_prey_rand>yub;
                ylb_flag2=y_prey_rand<ylb;
                x_prey_rand=(x_prey_rand.*(~(xub_flag2+xlb_flag2)))+xub.*xub_flag2+xlb.*xlb_flag2;
                y_prey_rand=(y_prey_rand.*(~(yub_flag2+ylb_flag2)))+yub.*yub_flag2+ylb.*ylb_flag2;
                %判断搜索到的状态是否比原来的好
                if answer(x(i,1),x(i,2))>answer(x_prey_rand,y_prey_rand...
                    && x_prey_rand~=x(i,1)&& y_prey_rand~=x(i,2)   )
                    x_follow = x(i,1)+rand*Step.*(x_prey_rand-x(i,1))./norm(x_prey_rand-x(i,1));
                    x_follow=round(x_follow,0);
                    y_follow = x(i,2)+rand*Step.*(y_prey_rand-x(i,2))./norm(y_prey_rand-x(i,2));
                    y_follow=round(y_follow,0);
                    xub_flag2=x_follow>xub;
                    xlb_flag2=x_follow<xlb;
                    yub_flag2=y_follow>yub;
                    ylb_flag2=y_follow<ylb;
                    x_follow=(x_follow.*(~(xub_flag2+xlb_flag2)))+xub.*xub_flag2+xlb.*xlb_flag2;
                    y_follow=(y_follow.*(~(yub_flag2+ylb_flag2)))+yub.*yub_flag2+ylb.*ylb_flag2;
                    follow_fitness=answer(x_follow,y_follow);
                    label_prey =1;
                    break;
                end

            end
            %随机行为
            if label_prey==0
                x_follow = x(i,1)+Step*(-1+2*rand);
                x_follow=round(x_follow,0);
                y_follow = x(i,2)+Step*(-1+2*rand);
                y_follow=round(y_follow,0);
                xub_flag2=x_follow>xub;
                xlb_flag2=x_follow<xlb;
                yub_flag2=y_follow>yub;
                ylb_flag2=y_follow<ylb;
                x_follow=(x_follow.*(~(xub_flag2+xlb_flag2)))+xub.*xub_flag2+xlb.*xlb_flag2;
                y_follow=(y_follow.*(~(yub_flag2+ylb_flag2)))+yub.*yub_flag2+ylb.*ylb_flag2;
                follow_fitness=answer(x_follow,y_follow);
            end
        end

        % 两种行为找最优
        if follow_fitness<swarm_fitness
            x(i,1)=x_follow;
            x(i,2)=y_follow;
        else
            x(i,1)=x_swarm;
            x(i,2)=y_swarm;
        end
    end
    temp = best_fitness;
    %% 更新信息
    for i = 1:N
        if (answer(x(i,1),x(i,2))<best_fitness)
            best_fitness = answer(x(i,1),x(i,2));
            best_x = x(i,1);
            best_y = x(i,2);
        end
    end
    
    Convergence_curve(Iteration)=best_fitness;
    Iteration = Iteration+1;
    if mod(Iteration,50)==0
        display(['迭代次数：',num2str(Iteration),'最优适应度：',num2str(best_fitness)]);
        display(['最优人工鱼：',num2str(best_x)]);
    end

    if(abs(best_fitness - temp)<=0.00001)
        label  = label + 1;
    else
        label = 0;
        temp = best_fitness;
    end

    if(label == 10)
        break;
    end

end



semilogy(Convergence_curve,'Color','k','LineWidth',1.2)
xlabel('Iteration');
ylabel('best_fitness');
axis tight
grid off
box on