%% 数值型数据缺失值处理前后对比
function [] = Data_Compare( odata, ndata )

ind = {'Surgery'; 'Age'; 'Hospital Number'; 'Rectal Temperature'; 'pulse'; 'respiratory rate'; 'temperature of extremities';'peripheral pulse';'mucous membranes'; 'capillary refill time'; 'pain'; 'peristalsis'; 'abdominal distension'; 'nasogastric tube'; 'nasogastric reflux'; 'nasogastric reflux PH'; 'rectal examination'; 'abdomen'; 'packed cell volume'; 'total protein'; 'abdominocentesis appearance'; 'abdomcentesis total protein'; 'outcome'; 'surgical lesion'; 'type of lesion1'; 'type of lesion2'; 'type of lesion3'; 'cp_data'};
index = reshape(ind, 1, 28);
%绘制直方图，用qq图检验其分布是否为正态分布。 
%绘制盒图，对离群值进行识别
list = [4,5,6,16,19,20,22];
for i = 1:28
    if ismember(i, list)
        attribute = index(i);
        ocol = odata(:, i);
        ncol = ndata(:, i);
        figure(find(list == i));
        subplot(2,3,1), hist(ocol), title(['处理前的直方图：',index(i)]);    %绘制原直方图
        subplot(2,3,2), qqplot(ocol), title(['处理前的QQ图：',index(i)]);   %绘制原QQ图
        subplot(2,3,3), boxplot(ocol), title(['处理前的盒图：',index(i)]);   %绘制原盒图
        subplot(2,3,4), hist(ncol), title(['处理后的直方图：',index(i)]);    %绘制处理后直方图
        subplot(2,3,5), qqplot(ncol), title(['处理后的QQ图：',index(i)]);   %绘制处理后QQ图
        subplot(2,3,6), boxplot(ncol), title(['处理后的盒图：',index(i)]);   %绘制处理后盒图
    end
end

end