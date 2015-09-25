function [notes music]=human2machine(record_wave, handles, type)
%     record_wave = wavread('success1.wav');
    freq=8000;
    T=1/freq;
    timeInter=0.4;

    %handle the duration of the notes.
    dur = containers.Map('KeyType', 'char', 'ValueType', 'any');
    dur('eighth note') = 0:T:timeInter/2;
    dur('quarter note') = 0:T:timeInter;
    dur('dotted quarter note') = 0:T:timeInter*1.5;
    dur('half note') = 0:T:timeInter*2;
    dur('dotted half note') = 0:T:timeInter*3;
    dur('whole note') = 0:T:timeInter*4;
    dur('unknown length') = 0:T:timeInter*2;

    amp = [1, 0.2, 0.3];
    n = length(amp);

    % first part of the piece
    [music,~] = notes_recognize(record_wave, handles, type);
    fre1 = note2f(music);
    notes = [];
    for i = 1:length(fre1)
       duration = music(i,end);
       note = sin(2*pi*fre1(i)*dur(duration{1}));
       note = note.*shape_env1(length(note));
       notes = [notes note];
    %    sound(note,8000);
    %    pause(1);
    end
    disp('hi')
    sound(notes);
end







