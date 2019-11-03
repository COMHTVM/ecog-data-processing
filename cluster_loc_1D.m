function loc = cluster_loc_1D(raw_loc,n,func)
%% Get k-means clusters
idx = kmeans(raw_loc',n);

%% To sort clusters
j=1;
for i=2:length(idx)
    if idx(i) == idx(i-1)
       idx(i-1) = j; 
    else
       idx(i-1) = j;
       j=j+1;
    end
end
idx(end) = j;

%% Get first,last or average locations of peaks (input func as function handle)
loc = zeros(1,n);
for k=1:n
    loc(k) = round(func(raw_loc(idx==k)));
end 
end