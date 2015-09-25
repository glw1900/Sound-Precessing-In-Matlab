function result_wave = pitch(wave, fs, bits, p, q)
    
    quo = p/q;
    e = pvoc(wave,quo,1024);
%     result_wave = resample(e,p,q);
%     quo
    result_wave = resample(e,p,q);
    % sound(f,sr);
    % soundsc(d(1:length(f))+f,sr);
end