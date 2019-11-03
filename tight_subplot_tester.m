figure
[ha, pos] = tight_subplot(3,2,[.1 .03],[.1 .01],[.1 .1])
for ii = 1:6; axes(ha(ii)); plot(randn(10,ii)); end
set(ha(1:4),'XTickLabel',''); set(ha,'YTickLabel','')