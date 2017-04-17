
%绘制直方图，如mxPH，用qq图检验其分布是否为正态分布
%绘制盒图，对离群值进行识别
a = xlsread('horse-colic.xlsx');
ind = {'Surgery'; 'Age'; 'Hospital Number'; 'Rectal Temperature'; 'pulse'; 'respiratory rate'; 'temperature of extremities';'peripheral pulse';'mucous membranes'; 'capillary refill time'; 'pain'; 'peristalsis'; 'abdominal distension'; 'nasogastric tube'; 'nasogastric reflux'; 'nasogastric reflux PH'; 'rectal examination'; 'abdomen'; 'packed cell volume'; 'total protein'; 'abdominocentesis appearance'; 'abdomcentesis total protein'; 'outcome'; 'surgical lesion'; 'type of lesion1'; 'type of lesion2'; 'type of lesion3'; 'cp_data'};
list = [4,5,6,16,19,20,22];
for i = 1:28
    if ismember(i, list)
        b = a(:,i);
        figure(find(list == i));
        subplot(1,3,1), hist(b);    %绘制直方图
        subplot(1,3,2), qqplot(b), title(ind(i));   %绘制QQ图
        subplot(1,3,3), boxplot(b);   %绘制盒图
    end
end