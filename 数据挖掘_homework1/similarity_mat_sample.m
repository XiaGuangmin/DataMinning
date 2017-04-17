function sim_mat = similarity_mat_sample(analytic_mat)

%   �˴�������ʵ��������ŷ����þ��룬���ԽСԽ���ơ������������������ƣ����������ע�͡�

ATTRIBUTE_L = 1;
ATTRIBUTE_H = 28; 

SIM_SIZE = size(analytic_mat, 1); % ���ƾ����С����analytic_mat������һ��

sim_mat = ones(SIM_SIZE, SIM_SIZE) * 999; % ��ʼ��Ϊ������
for i = 1: SIM_SIZE - 1
    for j = i + 1: SIM_SIZE
        merge = [[analytic_mat(i, ATTRIBUTE_L: ATTRIBUTE_H)]', ...
            [analytic_mat(j, ATTRIBUTE_L: ATTRIBUTE_H)]']; % ����������ת�úϲ�Ϊ������x2�ľ���
        [NaN_line, ~] = find(isnan(merge) == 1);
        merge(NaN_line, :) = [];
        
        sim_mat(i, j) = norm(merge(:, 1) - merge(:, 2)); % ��������ŷ����þ���
        sim_mat(j, i) = sim_mat(i, j); % �Գƾ���
    end
end

end