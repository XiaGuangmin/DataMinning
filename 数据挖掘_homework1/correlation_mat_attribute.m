function cor_mat = correlation_mat_attribute(analytic_mat)
%   就是行和列都是属性，value(i,j)是属性i和属性j的相关性。它是对称矩阵哟。
ATTRIBUTE_L = 1;
ATTRIBUTE_H = 28; % 在本数据集中属性23~28没有缺失值
COR_SIZE = ATTRIBUTE_H - ATTRIBUTE_L + 1; % 相关性矩阵的大小

cor_mat = -ones(COR_SIZE, COR_SIZE); % 初始化相关性矩阵，由于要取最大相关性，初始为最小值（-1）
for i = ATTRIBUTE_L: ATTRIBUTE_H - 1
    for j = i + 1: ATTRIBUTE_H
        %merge = [[analytic_mat(:, i)]', [analytic_mat(:, j)]']; % 将待求相关系数的两列并起来
        merge = analytic_mat(:, [i, j]);
        [NaN_line, ~] = find(isnan(merge) == 1);
        merge(NaN_line, :) = []; % 删掉含有NaN的行以便正确求解相关系数
        
        cor_indx = i - ATTRIBUTE_L + 1;
        cor_indy = j - ATTRIBUTE_L + 1; % 相关性矩阵下标
        cor_mat(cor_indx, cor_indy) = corr(merge(:, 1), merge(:, 2)); % merge的两列即去除NaN的两属性，求相关系数
        cor_mat(cor_indy, cor_indx) = cor_mat(cor_indx, cor_indy); % 对称矩阵
    end
end
cor_mat(isnan(cor_mat)) = -1;
end