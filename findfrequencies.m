function frequencies = findfrequencies(song,fs,head, tail, type)
    song = song/max(abs(song));  % Normalization
    frequencies = zeros(length(head),1);
    for(numSegment = 1:length(head))
        songSegment = song(head(numSegment):tail(numSegment));
        spectrum = fft(songSegment,8*length(songSegment));   % Take the Fourier transform
        spectrum = abs(spectrum(1:ceil(length(spectrum)/2)));
        numNote = 1;
        max(spectrum);
        if type==0  % 0=people voice, else=music
            threshold=2;
        else
            threshold=200;
        end
        if(max(spectrum) > threshold)
            %filter = gaussfilt(128);
            spectrum = spectrum .^ 2;
            %spectrum = conv(spectrum,filter);
            spectrum = spectrum/max(spectrum);
            for(i = 2:length(spectrum)-1)
                if(spectrum(i) > .1 & spectrum(i) > spectrum(i-1) & spectrum(i) > spectrum(i+1))
                    if(abs(i*fs/(length(spectrum)*2) - frequencies(numSegment,numNote)) > 10)
                        newFrequency = i*fs/(length(spectrum)*2);
                        if(numNote >= 2)
                            possibleHarmonics = 0;
                            for(j = 2:numNote)
                                   if(mod(newFrequency,frequencies(numSegment,j)) < .03*newFrequency | ...
                                    frequencies(numSegment,j) - mod(newFrequency,frequencies(numSegment,j))  < .03*newFrequency)
                                    if(spectrum(i) < .3*frequencies(numSegment,j)*2*length(spectrum)/fs)
                                        possibleHarmonics = 1;
                                    end
                                end
                            end
                            if(~possibleHarmonics)
                                numNote = numNote + 1;
                                frequencies(numSegment,numNote) = newFrequency;
                            end
                        else
                            numNote = numNote + 1;
                            frequencies(numSegment,numNote) = newFrequency;
                        end
                    end
                end
            end
        end
    end

    [rows,columns] = size(frequencies);
    if(columns >= 2)
        frequencies = frequencies(:,2:columns);
    end
end