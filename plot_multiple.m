function plot_multiple(x)
size_x = size(x);
for ii=1:size_x(1)
hold on
plot(mean(x(ii,:,:),3));
end

