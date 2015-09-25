function [head,tail] = notes_split(x, handles)  
    x = double(x);
    x = x / max(abs(x));  % Normalization
    FrameLen = 240;
    FrameInc = 80;
    status = 0;
    % Calculate short-time energy
    energy = sum(abs(enframe(filter([1 -0.9375], 1, x), FrameLen,FrameInc)), 2);
    p = 1; 
    min_energy=5;  
    max_energy=0;  
    for n=1:length(energy)
        switch status
            case 0,  % 0=no music
                if energy(n) > (min_energy+1)  
                    if max_energy < energy(n)  
                        max_energy = energy(n);
                    end
                    head(p) = n; 
                    status = 1;  
                else
                    status = 0;  
                    if min_energy > energy(n) 
                        min_energy = energy(n);  % Update minimum 
                    end
                end
            case 1,  % 1=music start
                if max_energy < energy(n) 
                    max_energy = energy(n);
                end
                if energy(n) < max_energy/2
                    tail(p) = n;  
                    p=p+1;  
                    status=0;  
                    max_energy=0;  
                    min_energy=energy(n); 
                end
        end
    end
%     subplot(211)
    axes(handles.axes3)
    cla;
    plot(x) 
    axis([1 length(x) -1 1])
    % axis([1 131072 -1 1])
    ylabel('Result');
    length(head)
    tail = [tail length(energy)];
    for n=1:length(head)  % The start is red and the end is yellow.
        line([head(n)*FrameInc head(n)*FrameInc], [-1 1],  'Color','red');
        line([tail(n)*FrameInc tail(n)*FrameInc], [-1 1],  'Color','yellow'); 
    end
    
%     subplot(212)
%     plot(energy); 
%     axis([1 length(energy) 0 max(energy)])
    % axis([1 6107 0 max(energy)])
%     ylabel('Energy');
%     for n=1:length(head) 
%         line([head(n) head(n)], [min(energy),max(energy)], 'Color','red');
%         line([tail(n) tail(n)], [min(energy),max(energy)], 'Color','yellow');
%     end
    head=(head*80)';
    tail=(tail*80)';
end