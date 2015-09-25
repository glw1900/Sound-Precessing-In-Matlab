function result_wave = vocal_elimination(wave,fs,bits)
    SoundLeft=wave(:,1);
    SoundRight=wave(:,2);

    NewLeft=SoundLeft-SoundRight;
    NewRight=SoundLeft-SoundRight;
    Sound(:,1)=NewLeft;
    Sound(:,2)=NewRight;

    BP=fir1(300,[500,2000]/(fs/2));  % bandpass filter with passband w1 < ¦Ø< w2.
    CutDown=filter(BP,1,Sound); 
    Sound_Final=Sound-0.6*abs(CutDown);

    result_wave = Sound_Final;
%     sound(Sound,fs,bits);
end