function sim_mat = similarity_mat_sample(analytic_mat)

%   此处相似性实际上求了欧几里得距离，因此越小越相似。其余与上述函数类似，不做多余的注释。

ATTRIBUTE_L = 1;
ATTRIBUTE_H = 28; 

SIM_SIZE = size(analytic_mat, 1); % 相似矩阵大小，与analytic_mat样本数一致

sim_mat = ones(SIM_SIZE, SIM_SIZE) * 999; % 初始化为最大距离
for i = 1: SIM_SIZE - 1
    for j = i + 1: SIM_SIZE
        merge = [[analytic_mat(i, ATTRIBUTE_L: ATTRIBUTE_H)]', ...
            [analytic_mat(j, ATTRIBUTE_L: ATTRIBUTE_H)]']; % 将两行样本转置合并为属性数x2的矩阵
        [NaN_line, ~] = find(isnan(merge) == 1);
        merge(NaN_line, :) = [];
        
        sim_mat(i, j) = norm(merge(:, 1) - merge(:, 2)); % 两样本的欧几里得距离
        sim_mat(j, i) = sim_mat(i, j); % 对称矩阵
    end
end

end