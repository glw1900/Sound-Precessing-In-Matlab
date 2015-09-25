function fre = note2f(music)
    music = music(:,1);
    fre = zeros(1,length(music));
    for i = 1:length(music)
        if strncmpi(music(i),'A#/Bb',2)
            fre(i) = 223.08;
        elseif strncmpi(music(i),'C#/Db',2)
            fre(i) = 138.59;
        elseif strncmpi(music(i),'D#/Eb',2)
            fre(i) = 146.83;
        elseif strncmpi(music(i),'G#/Ab',2)
            fre(i) = 207.65;    
        elseif strncmpi(music(i),'F#/Gb',2)
            fre(i) = 185.00;       
        elseif strncmpi(music(i),'A',1)
            fre(i) = 220;
        elseif strncmpi(music(i),'B',1)
            fre(i) = 246.94;
        elseif strncmpi(music(i),'C',1)
            fre(i) = 130.8;
        elseif strncmpi(music(i),'D',1)
            fre(i) = 146.83; 
        elseif strncmpi(music(i),'E',1)
            fre(i) = 164.81;
        elseif strncmpi(music(i),'F',1)
            fre(i) = 174.61;    
        elseif strncmpi(music(i),'G',1)
            fre(i) = 196.00;   
        end

        note = music(i);
        if strcmp(note{1},'') == 0
            pitch = str2num(note{1}(end));
            fre(i) = fre(i)*2^(pitch-2);
        end
    fre=fre;
end