%����ȱʧ�Ĵ���
a = xlsread('horse-colic.xlsx');
origin_a = a;
pattern = input('���������ݴ���ģʽ:\n','s');
%ȱʧֵ��������4--22

[m, n] = size(a); % �������Ĵ�С
ATTRIBUTE_L = 1;
ATTRIBUTE_H = 28;

standard_line = (a(1, ATTRIBUTE_L: ATTRIBUTE_H)); % ȡ��һ����ȱʧ����������Ϊ����2��ֵ������


switch(pattern)
    case '1'   %��ȱʧֵ�޳�
        a(any(isnan(a),2),:) = [];   %�������д���ȱʧֵ����������ɾ��
        xlswrite('NanProcessData_1.xlsx',a)   %�����ɵ��µ����ݼ��������ļ�
        Data_Compare(origin_a,a)             %�Ƚ��¾����ݲ�ʵ�ֿ��ӻ�
    case '2'   %�����Ƶ��ֵ���ȱʧֵ
        for i = 4:22
            for j = 1:368
                if(isnan(a(j,i)))
                   a(j,i) = mode(a(:,i));
                end 
            end
        end
        xlswrite('NanProcessData_2.xlsx',a);
        Data_Compare(origin_a,a);
    case '3'   %ͨ�����Ե���ع�ϵ���ȱʧֵ
        cor_mat = correlation_mat_attribute(a);
        cor_size = size(cor_mat, 1); % �����С������������Ƿ���
        for i = 1: m
            for j = ATTRIBUTE_L: ATTRIBUTE_H
                if(isnan(a(i, j)))
                    [~, index] = sort(cor_mat(j - ATTRIBUTE_L + 1, :));
                    index_list = fliplr(index); % sort����fliplr��ת����ɽ��򣬵õ��ο����������ȶ��б�
                    flag = 0; % ��ʶ�Ƿ�ȫ�ɹ�
                    for k = 1: cor_size
                        ref_attr = index_list(k); % ���ڲ�ȫ�ο�������
                        if(~isnan(a(i, ref_attr)))
                            a(i, j) = standard_line(j - ATTRIBUTE_L + 1) / standard_line(ref_attr) * ...
                                a(i, ref_attr + ATTRIBUTE_L - 1); % ��������ȫ���ⲻ����õķ�����
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
         sim_mat = similarity_mat_sample(a); % �������Ծ��󣬺�������
         sim_size = size(sim_mat, 1); % �����С������������Ƿ���
         for i = 1: m
             for j = ATTRIBUTE_L: ATTRIBUTE_H
                 if(isnan(a(i, j)))
                     [~, index_list] = sort(sim_mat(i, :));
                     flag = 0; % ��ʶ�Ƿ�ȫ�ɹ�
                     for k = 1: sim_size
                         ref_samp = index_list(k); % ���ڲ�ȫ�ο�������
                         if(~isnan(a(ref_samp, j)))
                             a(i, j) = a(ref_samp, j); % ԭ�����ϣ���ȫ
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
        

