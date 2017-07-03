%The Matlab streaming example online is actually a python notebook,
%with matlab code in it.  The first command isn't actually a matlab command.
%The first command should have been getplotlyfig.
%The example involves an existing plotly graph.
%To reterieve an existing plotly graph to matlab.
%plotlyfigure=getplotlyfig('matlab_user_guide',846)
%plotlyfigure=getplotlyfig('matlab_user_guide',846)
%There doesn't seem to exist a funciton yet for converting
%a plotlyfig back to a matlab fig.

%The stream id can be found under settings when you login to plotly.
%You can also create more stream ids.
plotlysetup('GlobalAI','Ky65tyitJhFKHLJpP4tv','stream_ids',{'jf7wxyyndf'})

my_credentials = loadplotlycredentials;
my_stream_token = my_credentials.stream_ids{end};

%----SETUP-----%
%For this particular example, none of the plotting is done in matlab.
%The data and layour information is just sent directly to plotly.
data{1}.x = [];
data{1}.y = [];
data{1}.type = 'scatter';
data{1}.stream.token = my_stream_token;
data{1}.stream.maxpoints = 60;
%Original example only had one trace To add a second with different
%data, you need to use a different token for the other trace.
data{2}.x = [];
data{2}.y = [];
data{2}.type = 'scatter';
data{2}.stream.token = 'nj6qaaol69';  %Created another stream id to have another line in the plot.
%To include this stream id the plotlysetup command should be.
%plotlysetup('GlobalAI','Ky65tyitJhFKHLJpP4tv','stream_ids',{'jf7wxyyndf',nj6aao169'})
data{2}.stream.maxpoints = 60;
data{2}.marker.color='orange';
args.filename = 'MY_FIRST_STREAM';
args.fileopt = 'overwrite';  %This keeps you from making new fileids
%with each new plotly plot.

%----PLOTLY-----%

resp = plotly(data,args);
URL_OF_PLOT = resp.url

%%matlab
ps = plotlystream(my_stream_token);
ps2 = plotlystream('nj6qaaol69');

ps.open();
ps2.open();

%----write to the stream----%

for i = 1:1000
    mydata.x = i;
    mydata.y = rand;

    ps.write(mydata);
    mydata.x = i;
    mydata.y = 2+rand;
    ps2.write(mydata);
    %take a breath
    pause(0.1);
end

%----close the stream----%

ps.close();
ps2.close();
