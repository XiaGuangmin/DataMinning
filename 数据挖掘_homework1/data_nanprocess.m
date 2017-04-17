%数据缺失的处理
a = xlsread('horse-colic.xlsx');
origin_a = a;
pattern = input('请输入数据处理模式:\n','s');
%缺失值的列数是4--22

[m, n] = size(a); % 输入矩阵的大小
ATTRIBUTE_L = 1;
ATTRIBUTE_H = 28;

standard_line = (a(1, ATTRIBUTE_L: ATTRIBUTE_H)); % 取出一行无缺失的样本，作为方法2插值的依据


switch(pattern)
    case '1'   %将缺失值剔除
        a(any(isnan(a),2),:) = [];   %将数据中存在缺失值的样本整个删除
        xlswrite('NanProcessData_1.xlsx',a)   %将生成的新的数据集存入新文件
        Data_Compare(origin_a,a)             %比较新旧数据并实现可视化
    case '2'   %用最高频率值来填补缺失值
        for i = 4:22
            for j = 1:368
                if(isnan(a(j,i)))
                   a(j,i) = mode(a(:,i));
                end 
            end
        end
        xlswrite('NanProcessData_2.xlsx',a);
        Data_Compare(origin_a,a);
    case '3'   %通过属性的相关关系来填补缺失值
        cor_mat = correlation_mat_attribute(a);
        cor_size = size(cor_mat, 1); % 矩阵大小，正常情况下是方阵
        for i = 1: m
            for j = ATTRIBUTE_L: ATTRIBUTE_H
                if(isnan(a(i, j)))
                    [~, index] = sort(cor_mat(j - ATTRIBUTE_L + 1, :));
                    index_list = fliplr(index); % sort升序，fliplr翻转，变成降序，得到参考的属性优先度列表
                    flag = 0; % 标识是否补全成功
                    for k = 1: cor_size
                        ref_attr = index_list(k); % 用于补全参考的属性
                        if(~isnan(a(i, ref_attr)))
                            a(i, j) = standard_line(j - ATTRIBUTE_L + 1) / standard_line(ref_attr) * ...
                                a(i, ref_attr + ATTRIBUTE_L - 1); % 按比例补全（这不是最好的方法）
                            flag = 1;
                            break
                        end
                    end
                    if(flag == 0)
                        disp(['Insert fail at row ', num2str(i), ' col ', num2str(j)]);
                        return ;
                    end
                end
            end
        end
        xlswrite('NanProcessData_3.xlsx', a); 
        Data_Compare(origin_a,a);
    case '4'
         sim_mat = similarity_mat_sample(a); % 获得相关性矩阵，函数见下
         sim_size = size(sim_mat, 1); % 矩阵大小，正常情况下是方阵
         for i = 1: m
             for j = ATTRIBUTE_L: ATTRIBUTE_H
                 if(isnan(a(i, j)))
                     [~, index_list] = sort(sim_mat(i, :));
                     flag = 0; % 标识是否补全成功
                     for k = 1: sim_size
                         ref_samp = index_list(k); % 用于补全参考的属性
                         if(~isnan(a(ref_samp, j)))
                             a(i, j) = a(ref_samp, j); % 原样填上，补全
                             flag = 1;
                             break;
                         end
                     end
                     if(flag == 0)
                         disp(['Insert fail at row ', num2str(i), ' col ', num2str(j)]);
                         return ; 
                     end
                 end
             end
         end
         xlswrite('NanProcessData_4.xlsx', a);
         Data_Compare(origin_a, a);
end
        

