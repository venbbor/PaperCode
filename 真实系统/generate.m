T = 10:5:300;
N = 10:1:50;
mesh(T,N,answer(10:1:50,10:5:300));
text(97,15,214.3,"*",'Color','red','FontSize',20);


% T = 80:30:1800;
% N = 5:1:50;
% mesh(T,N,answer(5:1:50,80:30:1800));
% text(1214,12,47,"*",'Color','red','FontSize',20);

% N_1=zeros(4,90);
% 
% plot(20:90,N_1(1,20:90),':k','LineWidth',1.2)
% hold on
% plot(20:90,N_1(2,20:90),'--k','LineWidth',1.2)
% hold on 
% plot(20:90,N_1(3,20:90),'k','LineWidth',1.2)
% hold on
% plot(20:90,N_1(4,20:90),'-.k','LineWidth',1.2)

% cd = [72,76,80,84,88];
% c = [53.1467,53.8862,54.6257,55.3387,56.0380];
% plot(cd,c,'-.ok','LineWidth',1.2);
% 
% xx = [-0.1,-0.05,0,0.05,0.1];
% y = [-2.71,-1.35,0,1.31,2.59];
% plot(x,y,'-.ok','LineWidth',1.2)


% x = 54.6257;
% y1 = [53.1467,53.8862,54.6257,55.3387,56.0380];
% y2 = [53.2854,53.9950,54.6257,55.2838,55.9283];
% y3 = [51.9791,53.3388,54.6257,55.9843,57.1257];
% y1 = (x-y1)/x;
% y2 = (x-y2)/x;
% y3 = (x-y3)/x;
% plot(xx,-y1,'-ok','LineWidth',1.2);
% hold on;
% plot(xx,-y2,'-.sk','LineWidth',1.2);
% hold on;
% plot(xx,-y3,':*k','LineWidth',1.2);

% x = 72.7916;
% y1 = [68.6279,70.7291,72.7916,74.8365,76.8078];
% y2 = [69.6002,71.2374,72.7916,74.3342,75.8380];
% y1 = (x-y1)/x;
% y2 = (x-y2)/x;
% plot(xx,-y1,'-ok','LineWidth',1.2);
% hold on;
% plot(xx,-y2,'-.sk','LineWidth',1.2);
