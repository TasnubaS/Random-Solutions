function[result] = func(data)
% Final features will be the averages and stds labelled for all

%data = xlsread('G7NZCJ008056297-Michael-left-hand_wash-soap-2019-09-24-08-21-41.csv');% load a csv
time_mili= data(:,1);
format shortG
time_s_decimal= time_mili/1000;
h = histogram(time_s_decimal);% make bin
edges = h.BinEdges;
[~,~,loc]=histcounts(time_s_decimal,edges);
x = data(:,2);
mean_x = accumarray(loc(:),x(:))./accumarray(loc(:),1);%average for the timestamps
std_x = accumarray(loc, x', [length(unique(loc)),1], @std);
y = data(:,3);
mean_y = accumarray(loc(:),y(:))./accumarray(loc(:),1);
std_y = accumarray(loc, y', [length(unique(loc)),1], @std);
z= data(:,4);
mean_z = accumarray(loc(:),z(:))./accumarray(loc(:),1);
std_z = accumarray(loc, z', [length(unique(loc)),1], @std);

result= [mean_x, std_x, mean_y, std_y, mean_z, std_z]; % For each subject several bins will be on the file (windowing)

Fraction_9=abs(rem(time_s_decimal(end), 1));
if Fraction_9 <= 0.9
    % Discard the last bin
    result = result(1:(end-1),:);
end
end