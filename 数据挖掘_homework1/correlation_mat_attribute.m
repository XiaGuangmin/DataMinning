function cor_mat = correlation_mat_attribute(analytic_mat)
%   �����к��ж������ԣ�value(i,j)������i������j������ԡ����ǶԳƾ���Ӵ��
ATTRIBUTE_L = 1;
ATTRIBUTE_H = 28; % �ڱ����ݼ�������23~28û��ȱʧֵ
COR_SIZE = ATTRIBUTE_H - ATTRIBUTE_L + 1; % ����Ծ���Ĵ�С

cor_mat = -ones(COR_SIZE, COR_SIZE); % ��ʼ������Ծ�������Ҫȡ�������ԣ���ʼΪ��Сֵ��-1��
for i = ATTRIBUTE_L: ATTRIBUTE_H - 1
    for j = i + 1: ATTRIBUTE_H
        %merge = [[analytic_mat(:, i)]', [analytic_mat(:, j)]']; % ���������ϵ�������в�����
        merge = analytic_mat(:, [i, j]);
        [NaN_line, ~] = find(isnan(merge) == 1);
        merge(NaN_line, :) = []; % ɾ������NaN�����Ա���ȷ������ϵ��
        
        cor_indx = i - ATTRIBUTE_L + 1;
        cor_indy = j - ATTRIBUTE_L + 1; % ����Ծ����±�
        cor_mat(cor_indx, cor_indy) = corr(merge(:, 1), merge(:, 2)); % merge�����м�ȥ��NaN�������ԣ������ϵ��
        cor_mat(cor_indy, cor_indx) = cor_mat(cor_indx, cor_indy); % �Գƾ���
    end
end
cor_mat(isnan(cor_mat)) = -1;
end