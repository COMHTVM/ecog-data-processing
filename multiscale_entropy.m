function [ mse nb_match_m nb_match_m1] = multiscale_entropy(x,m,r,nsf)
 
%put x in a column
if size(x,2)~=1
    x=x';
end
    
l=length(x);
mse=zeros(nsf,1);

for i=1:nsf
    %get coarsegrain from signal x
    s=mean(reshape(x(1:floor(l/i)*i),i,floor(l/i),1),1)';
    %get mse for s
    [mse(i) nb_match_m nb_match_m1] =sample_entropy(s,m+1,r);
end

end

function [se nb_match_m nb_match_m1]  = sample_entropy(x,m,r)

l=length(x);
nb_match_1=0;
nb_match_m=0;
nb_match_m1=0;

for i=1:l-m
    %for each sample i, find the samples that match
    match=abs(x(i+1:l-m+1)-x(i))<r;
    [~,list_match]=find(match'==1);
    nb_match_i=length(list_match);
    %get number of matches for m=1
    nb_match_1=nb_match_1+nb_match_i;
    %for each matching sample find if m-1 and m match too
    for j=1:nb_match_i
        k=1;
        %as long as samples following matching samples match, keep going
        %(stop if not or reach longer m)
        while (k<m) && (abs(x(list_match(j)+i+k)-x(i+k))<r)
            %get number of matches for m
            if k==m-1
                nb_match_m=sum(abs(x(list_match(j)+i+k)-x(i+k))<r)+nb_match_m;
            %get number of matches for m-1
            elseif k==m-2
                nb_match_m1=sum(abs(x(list_match(j)+i+k)-x(i+k))<r)+nb_match_m1;
            end
            k=k+1;
        end
    end
end

%different cases depending on m
if m==2
  se=-log(nb_match_m/nb_match_1);
else
  se=-log(nb_match_m/nb_match_m1);
end

end
