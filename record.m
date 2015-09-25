function record_wave = record(time)
%     disp('Start speaking.')
        recObj = audiorecorder;
        recordblocking(recObj, time);
        play(recObj);
    %     disp('End of Recording.');
        record_wave = getaudiodata(recObj);
    %     audiowrite('music.wav',record_wave, 8000);
end