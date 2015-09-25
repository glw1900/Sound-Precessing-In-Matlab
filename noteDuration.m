function [music,tempo] = noteDuration(head,tail,notes,fs)
    durs = zeros(1,length(head));
    for n = 1:length(durs)
        durs(n)=tail(n)-head(n);
    end
    dist=zeros(1,ceil(max(durs)/1000)*1000);
    for n = 1:length(durs)
        if durs(n) ~= 0
            dist(durs(n))=dist(durs(n))+1;
        end
    end
    N = 60;
    histdist=histc(durs,0:ceil(length(dist)/N):length(dist));

    % bar([0:ceil(length(dist)/N):length(dist)]/fs,histdist);
    % title('Histogram of Note Durations','fontsize',28);
    % xlabel('Duration (s)','fontsize',28);
    % ylabel('Number of occurences','fontsize',28);

    [val,loc]=max(histdist);
    loc = (loc-.5)*length(dist)/N;
    quarter=avex2(dist(ceil(loc*7/8):min(length(dist),floor(loc*9/8))),ceil(loc*7/8));
    num8=round(2*durs/quarter);
    lengths = cell(length(durs),1);
    for n = 1:length(durs)
        switch(num8(n))
            case 1
                lengths(n) = cellstr('eighth note');
            case 2
                lengths(n) = cellstr('quarter note');
            case 3
                lengths(n) = cellstr('dotted quarter note');
            case 4
                lengths(n) = cellstr('half note');
            case 6
                lengths(n) = cellstr('dotted half note');
            case 8
                lengths(n) = cellstr('whole note');
            otherwise
                lengths(n) = cellstr('unknown length');
        end
    end
    sz=size(notes);
    music = cell(sz(1),sz(2)+1);
    for r = 1:sz(1)
        for c = 1:sz(2)
            music{r,c}=notes{r,c};
        end
        music{r,end}=lengths{r};
    end
    tempo = 60*fs/quarter;
end

% helper function to find the average x value in a distribution f.
function x = avex2(f,start)
if (nargin < 2)
    start = 1;
end
x = sum(([1:length(f)]+start-1).*f)/sum(f);
end