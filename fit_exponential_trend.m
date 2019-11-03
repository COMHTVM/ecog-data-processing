x_exp_fit = double(x_baseline_detrend);
t_fit_test = (2025/2000-1:1/2000:4000/2000-1);
fit_a_coeff = zeros(size_x(2),50);
fit_b_coeff = zeros(size_x(2),50);
for ii = 1:size_x(2)
for jj = 51:100
chan_fit = fit(t_fit_test',x_exp_fit(2025:4000,ii,jj),'exp1');
fit_b_coeff(ii,jj-50) = chan_fit.b;
fit_a_coeff(ii,jj-50) = chan_fit.a;
end
end
RC = 1./fit_b_coeff;
mean(RC,2)
std(RC,2)