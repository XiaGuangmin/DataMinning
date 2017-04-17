%对标称属性，给出每个可能取值的频数
%数值属性，给出最大、最小、均值、中位数、四分位数以及缺失值的个数
clear ; close all; clc
a = xlsread('horse-colic.xlsx');

ind = {'Surgery'; 'Age'; 'Hospital Number'; 'Rectal Temperature'; 'pulse'; 'respiratory rate'; 'temperature of extremities';'peripheral pulse';'mucous membranes'; 'capillary refill time'; 'pain'; 'peristalsis'; 'abdominal distension'; 'nasogastric tube'; 'nasogastric reflux'; 'nasogastric reflux PH'; 'rectal examination'; 'abdomen'; 'packed cell volume'; 'total protein'; 'abdominocentesis appearance'; 'abdomcentesis total protein'; 'outcome'; 'surgical lesion'; 'type of lesion1'; 'type of lesion2'; 'type of lesion3'; 'cp_data'};
index = reshape(ind, 1, 28);


for i = 1:29
    %%人工区别标称属性和数值属性
    if ismember(i,[1,2,3,7,8,9,10,11,12,13,14,15,17,18,21,23,24,25,26,27,28])
        c = a(:,i);
        c = c(~isnan(c));   %删除缺失值
        b = num2str(c);     %转化成字符串形式
        disp(ind(i));        %输出属性名称
        tabulate(b);         %利用matlab原有命令统计频率
        fprintf('\n\n')      
    end
    if ismember(i,[4,5,6,16,19,20,22])
        c = a(:,i);
        none_v = sum(isnan(c(:)));    %统计缺失值个数
        c = c( ~ isnan(c));           %删除缺失值
        max_v = max(c);          %最大值
        min_v = min(c);          %最小值
        mean_v = mean(c);        %均值
        median_v = median(c);    %中位数
        Q1 = prctile(c, 25);   %上四分位数
        Q2 = prctile(c, 75);   %下四分位数 
        %将上述结果保存在一个二维数组中
        Statistic_Info = ['Max_v:', num2str(max_v), '   Min_v:', num2str(min_v), '   Mean_v:', num2str(mean_v), '   Median_v:', num2str(median_v), '   Q1:', num2str(Q1), '   Q2:', num2str(Q2), '   None_v:', num2str(none_v)]; 
        disp(ind(i));
        disp(Statistic_Info)
         fprintf('\n\n\n') 
    end
end