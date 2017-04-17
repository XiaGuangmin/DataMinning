%�Ա�����ԣ�����ÿ������ȡֵ��Ƶ��
%��ֵ���ԣ����������С����ֵ����λ�����ķ�λ���Լ�ȱʧֵ�ĸ���
clear ; close all; clc
a = xlsread('horse-colic.xlsx');

ind = {'Surgery'; 'Age'; 'Hospital Number'; 'Rectal Temperature'; 'pulse'; 'respiratory rate'; 'temperature of extremities';'peripheral pulse';'mucous membranes'; 'capillary refill time'; 'pain'; 'peristalsis'; 'abdominal distension'; 'nasogastric tube'; 'nasogastric reflux'; 'nasogastric reflux PH'; 'rectal examination'; 'abdomen'; 'packed cell volume'; 'total protein'; 'abdominocentesis appearance'; 'abdomcentesis total protein'; 'outcome'; 'surgical lesion'; 'type of lesion1'; 'type of lesion2'; 'type of lesion3'; 'cp_data'};
index = reshape(ind, 1, 28);


for i = 1:29
    %%�˹����������Ժ���ֵ����
    if ismember(i,[1,2,3,7,8,9,10,11,12,13,14,15,17,18,21,23,24,25,26,27,28])
        c = a(:,i);
        c = c(~isnan(c));   %ɾ��ȱʧֵ
        b = num2str(c);     %ת�����ַ�����ʽ
        disp(ind(i));        %�����������
        tabulate(b);         %����matlabԭ������ͳ��Ƶ��
        fprintf('\n\n')      
    end
    if ismember(i,[4,5,6,16,19,20,22])
        c = a(:,i);
        none_v = sum(isnan(c(:)));    %ͳ��ȱʧֵ����
        c = c( ~ isnan(c));           %ɾ��ȱʧֵ
        max_v = max(c);          %���ֵ
        min_v = min(c);          %��Сֵ
        mean_v = mean(c);        %��ֵ
        median_v = median(c);    %��λ��
        Q1 = prctile(c, 25);   %���ķ�λ��
        Q2 = prctile(c, 75);   %���ķ�λ�� 
        %���������������һ����ά������
        Statistic_Info = ['Max_v:', num2str(max_v), '   Min_v:', num2str(min_v), '   Mean_v:', num2str(mean_v), '   Median_v:', num2str(median_v), '   Q1:', num2str(Q1), '   Q2:', num2str(Q2), '   None_v:', num2str(none_v)]; 
        disp(ind(i));
        disp(Statistic_Info)
         fprintf('\n\n\n') 
    end
end