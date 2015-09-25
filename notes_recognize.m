function [music,tempo]=notes_recognize(song, handles, type)
%     [song,fs] = wavread('success1.wav');
    fs=8000;
    song=song(:,1);
    [head,tail]=notes_split(song, handles);  % split tone
    frequencies = findfrequencies(song,fs,head,tail, type);   % get frequency of keynote
    notes = frequency2note(frequencies);   % frequency to note
    [music,tempo] = noteDuration(head,tail,notes,fs);   % get beat
end