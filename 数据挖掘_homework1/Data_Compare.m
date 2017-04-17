%% ��ֵ������ȱʧֵ����ǰ��Ա�
function [] = Data_Compare( odata, ndata )

ind = {'Surgery'; 'Age'; 'Hospital Number'; 'Rectal Temperature'; 'pulse'; 'respiratory rate'; 'temperature of extremities';'peripheral pulse';'mucous membranes'; 'capillary refill time'; 'pain'; 'peristalsis'; 'abdominal distension'; 'nasogastric tube'; 'nasogastric reflux'; 'nasogastric reflux PH'; 'rectal examination'; 'abdomen'; 'packed cell volume'; 'total protein'; 'abdominocentesis appearance'; 'abdomcentesis total protein'; 'outcome'; 'surgical lesion'; 'type of lesion1'; 'type of lesion2'; 'type of lesion3'; 'cp_data'};
index = reshape(ind, 1, 28);
%����ֱ��ͼ����qqͼ������ֲ��Ƿ�Ϊ��̬�ֲ��� 
%���ƺ�ͼ������Ⱥֵ����ʶ��
list = [4,5,6,16,19,20,22];
for i = 1:28
    if ismember(i, list)
        attribute = index(i);
        ocol = odata(:, i);
        ncol = ndata(:, i);
        figure(find(list == i));
        subplot(2,3,1), hist(ocol), title(['����ǰ��ֱ��ͼ��',index(i)]);    %����ԭֱ��ͼ
        subplot(2,3,2), qqplot(ocol), title(['����ǰ��QQͼ��',index(i)]);   %����ԭQQͼ
        subplot(2,3,3), boxplot(ocol), title(['����ǰ�ĺ�ͼ��',index(i)]);   %����ԭ��ͼ
        subplot(2,3,4), hist(ncol), title(['������ֱ��ͼ��',index(i)]);    %���ƴ����ֱ��ͼ
        subplot(2,3,5), qqplot(ncol), title(['������QQͼ��',index(i)]);   %���ƴ����QQͼ
        subplot(2,3,6), boxplot(ncol), title(['�����ĺ�ͼ��',index(i)]);   %���ƴ�����ͼ
    end
end

end