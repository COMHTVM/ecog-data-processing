fs = 500;
n = 60*fs; %1-min sequence	
m = 10; %number of channels
t = 2*pi*(1:n)/fs;
fline = 60 + randn; %ramdom interference frequency
s = filter(1,[1,-0.99],100*randn(n,m))'; %1/f PSD
p = bsxfun(@times,sin(fline*t+randn), (80+5*randn(m,1))) ...
+ bsxfun(@times,sin(2*fline*t+randn), (50+5*rand(m,1))) ...
+ bsxfun(@times,sin(3*fline*t+randn), (20+5*randn(m,1))); % interference	
x = s + p;
sbar = removePLI_multichan(x, fs, 3, [50,0.01,4], [0.1,2,4], 2);
pwelch(s(1,:),[],[],[],fs); title('PSD of the original signal')
figure; pwelch(x(1,fs:end),[],[],[],fs); 
title('PSD of the contaminated signal');
figure; pwelch(sbar(1,fs:end),[],[],[],fs); 
title('PSD after interference cancellation');