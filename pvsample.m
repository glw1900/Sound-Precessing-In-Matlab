function c = pvsample(b, t, hop)
    if nargin < 3
      hop = 0;
    end
    [rows,cols] = size(b);
    N = 2*(rows-1);
    if hop == 0
      hop = N/2;  % default value
    end
    c = zeros(rows, length(t));
    dphi = zeros(1,N/2+1);
    dphi(2:(1 + N/2)) = (2*pi*hop)./(N./(1:(N/2)));
    % Phase accumulator
    % Preset to phase of first frame for perfect reconstruction
    % in case of 1:1 time scaling
    ph = angle(b(:,1));
    % Append a 'safety' column on to the end of b to avoid problems 
    % taking *exactly* the last frame (i.e. 1*b(:,cols)+0*b(:,cols+1))
    b = [b,zeros(rows,1)];
    ocol = 1;
    for tt = t
      bcols = b(:,floor(tt)+[1 2]);  % Grab the two columns of b
      tf = tt - floor(tt);
      bmag = (1-tf)*abs(bcols(:,1)) + tf*(abs(bcols(:,2)));
      dp = angle(bcols(:,2)) - angle(bcols(:,1)) - dphi';   % calculate phase advance
      dp = dp - 2 * pi * round(dp/(2*pi));  % Reduce to -pi:pi range
      c(:,ocol) = bmag .* exp(j*ph);  
      ph = ph + dphi' + dp;
      ocol = ocol+1;
end
