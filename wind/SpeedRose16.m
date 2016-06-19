function SpeedRose16(speed,direction,const)
%% wind-speed graph
    % input:
    %   speed is the wind speed n by 1 vector
    %   direction is the direction n by 1 vector
    %   const is static wind's frequency
    % output:
    %   graph of speed rose
    %---------------------------------
    % author: Yujia Cheng @ Ocean University of China, Master of OE
    % complete: June 18th, 2016
    
%% initial value
if nargin < 3
    const = 0;
end
m = 5;  %圈数
wn = 1/m;
dir_ang = (0:22.5:360)*pi/180;
ang_cyc = 0:0.01:2*pi;
speed = speed(:);
direction = direction(:);

%% divided into groups
ival_up = (dir_ang(1:end-1)*180/pi+22.5/2)';
ival_down = (dir_ang(1:end-1)*180/pi-22.5/2)';
ival_down(1) = ival_up(end);
ival = [ival_down,ival_up];
wind_count = zeros(16,3);
for i = 1:size(direction,1)
    if (direction(i)>=0 && direction(i)<=ival(1,2)) || ...
            (direction(i)>=ival(1,1) && direction(i)<=360)
        wind_count(1,1) = wind_count(1,1)+1;
        wind_count(1,2) = wind_count(1,2)+speed(i);
    else
        for j = 2:size(ival,1)
            if direction(i) >= ival(j,1) && direction(i) <= ival(j,2)
                wind_count(j,1) = wind_count(j,1)+1;
                wind_count(j,2) = wind_count(j,2)+speed(i);
                break
            end
        end
    end
end
wind_count(:,3) = wind_count(:,2)./wind_count(:,1);
w = ceil(max(wind_count(:,3))/m);    %每一格从po/5变为[max(po)/5]+1（取整函数）
po = wind_count(:,3)*wn/w+0.08;   %相当于po/(m*w)

%% line grid
for i=1:17
    plot([-1.08 -0.08]*cos(dir_ang(i)),[-1.08 -0.08]*sin(dir_ang(i)),'k');
    hold on
    plot([0.08 1.08]*cos(dir_ang(i)),[0.08 1.08]*sin(dir_ang(i)),'k');
    hold on
end

%% circle grid
text(0*wn+0.08,0.04,num2str(0*w));
hold on
for i=1:m
    plot((i*wn+0.08)*cos(ang_cyc),(i*wn+0.08)*sin(ang_cyc),'k:')
    %text((i-0.4)*wn,0.04,[num2str(i*w*100),'%']);
    text((i)*wn+0.08,0.04,num2str(i*w));
    hold on 
end

%% circle for static wind
plot(0.08*cos(ang_cyc),0.08*sin(ang_cyc),'k')
hold on

%% plot
ival(1,1) = 0-22.5/2;
ival_rad = ival*pi/180;
for i = 1:size(ival_rad,1)
    plot([0.08 po(i)]*sin(ival_rad(i,1)),[0.08 po(i)]*cos(ival_rad(i,1)),...
        'b');
    hold on
    plot([0.08 po(i)]*sin(ival_rad(i,2)),[0.08 po(i)]*cos(ival_rad(i,2)),...
        'b');
    hold on
    plot(po(i)*sin(ival_rad(i,1):0.01:ival_rad(i,2)),...
        po(i)*cos(ival_rad(i,1):0.01:ival_rad(i,2)),'r');
    hold on
end

%% text
[max_speed,ind] = max(wind_count(:,3));
max_dir = dir_ang(ind)*180/pi;
title('风速玫瑰图','unit','normalized','position',[1 1],...
    'FontSize',20);
text(1.18,1,{['最大平均风速：',num2str(max_speed),'m/s'];...
    ['对应方向：',num2str(max_dir),'°']},'FontSize',12);
text(-0.02,0.02,[num2str(const),'%']);
text(-0.03,-0.02,'静风');
text((m*wn+0.11)*sin(1/180*pi),(m*wn+0.11)*cos(0/180*pi),'N','rotation',180)
text((m*wn+0.1)*sin(21/180*pi),(m*wn+0.1)*cos(17.5/180*pi),'NNE','rotation',337)
text((m*wn+0.1)*sin(45/180*pi),(m*wn+0.1)*cos(42/180*pi),'NE','rotation',315)
text((m*wn+0.1)*sin(67.5/180*pi),(m*wn+0.1)*cos(65.5/180*pi),'ENE','rotation',292.5)
text((m*wn+0.1)*sin(88/180*pi),(m*wn-0.8)*cos(88/180*pi),'E','rotation',0)
text((m*wn+0.05)*sin(105.5/180*pi),(m*wn+0.6)*cos(107/180*pi),'ESE','rotation',67.5)
text((m*wn)*sin(130/180*pi),(m*wn+0.25)*cos(130.5/180*pi),'SE','rotation',45)
text((m*wn-0.25)*sin(148.5/180*pi),(m*wn+0.2)*cos(151/180*pi),'SSE','rotation',22.5)
text((m*wn+0.11)*sin(179.5/180*pi),(m*wn+0.11)*cos(180/180*pi),'S','rotation',180)
text((m*wn+0.9)*sin(194/180*pi),(m*wn+0.03)*cos(191/180*pi),'SSW','rotation',-22.5)
text((m*wn+0.3)*sin(219/180*pi),(m*wn)*cos(220/180*pi),'SW','rotation',-45)
text((m*wn+0.2)*sin(240.5/180*pi),(m*wn-0.3)*cos(238/180*pi),'WSW','rotation',-67.5)
text((m*wn+0.15)*sin(268/180*pi),(m*wn-0.8)*cos(268/180*pi),'W','rotation',0)
text((m*wn+0.1)*sin(287/180*pi),(m*wn+0.1)*cos(290/180*pi),'WNW','rotation',67.5)
text((m*wn+0.1)*sin(313/180*pi),(m*wn+0.1)*cos(314/180*pi),'NW','rotation',45)
text((m*wn+0.1)*sin(335/180*pi),(m*wn+0.1)*cos(336.5/180*pi),'NNW','rotation',22.5)
axis off
axis equal
