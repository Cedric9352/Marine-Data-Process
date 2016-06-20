function TimeSeries(var,M)
%% speed time-series graph
    % input:
    %   var is the name of variable
    %   M is the matrix of wind speed or direction
    % output:
    %   time series of speed or direction
    %---------------------------------
    % author: Yujia Cheng @ Ocean University of China, Master of OE
    % complete: June 20th, 2016
    
%% initial value
cname = cell(24,31);
day = size(M,1);
for i = 1:24
    for j = 1:day
        if i < 11 && j < 10
            cname{i,j} = strcat('0',num2str(j),'D','0',num2str(i-1),'h');
        elseif i < 11 && j >= 10
            cname{i,j} = strcat(num2str(j),'D','0',num2str(i-1),'h');
        elseif i >= 11 && j < 10
            cname{i,j} = strcat('0',num2str(j),'D',num2str(i-1),'h');
        else
            cname{i,j} = strcat(num2str(j),'D',num2str(i-1),'h');
        end
    end
end
cname = cname(:)';
cname = cname(25:31:744);

%% plot
total = size(M(:),1);
h = plot(0:total-1,M(:));
set(h,'Marker','.','MarkerEdgeColor','r')
set(gca,'xtick',24:31:743,'xticklabel',cname);
xlabel('Time(Day/Hour)')
if strcmp(var,'wind')
    legend('wind speed');
    ylabel('Wind-Speed(m/s)')
    title('风速时间序列','unit','normalized','position',[0.5 0.95],...
        'FontSize',20);
elseif strcmp(var,'direction')
    legend('wind direction');
    ylabel('Wind-Direction(degree)')
    title('风向时间序列','unit','normalized','position',[0.5 0.95],...
        'FontSize',20);
else
    error('wrong arguments');
end
box off