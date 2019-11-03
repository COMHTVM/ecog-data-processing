function x_interp = cubic_interp(x, pulse_duration_ms,fs,event_loc) 
% pulse_duration_ms = 20;
% fs = 2000;
%event_loc = 2000;
pulse_onesided_duration = pulse_duration_ms/2*fs/1000;
size_x = size(x);

pad = 150;
interp_freq = 3;
from = event_loc-pulse_onesided_duration;
to = event_loc+pulse_onesided_duration;
x_fit = x;

interp_period = round(pad/interp_freq);
t = 0:to-from+2*pad;
xx = [0:interp_period:pad,to-from+pad:interp_period:to-from+2*pad];
figure
for ii=1:size_x(2)
    for jj = 1:size_x(3)
        y = x_fit(from-pad+xx,ii,jj);
        yy = csapi(xx,y,t);
        x_fit(from:to,ii,jj) = yy(pad:to-from+pad);
    end
    hold on;
    plot(mean(x_fit(:,ii,:),3));
end
x_interp = x_fit;