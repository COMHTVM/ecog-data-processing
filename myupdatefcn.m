function txt = myupdatefcn(empt,event_obj)
% Customizes text of data tips

pos = get(event_obj,'Position');
chan = get(event_obj,'Target');
txt = {['Time (ms): ',num2str(pos(1))],...
	      ['Amplitude (uV): ',num2str(pos(2))],...
          ['Channel: ', num2str(chan.MarkerSize)]};