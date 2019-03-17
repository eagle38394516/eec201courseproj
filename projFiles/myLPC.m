function [a, gain, a_, acCos] = myLPC(frameDots, order)
%
% Compute the LPC coefficients using autocorrelation method solution.
%
% Inputs:
%   frameDots
%   order
%
% Outputs:
%   a       The denominator vector for the lpc solution
%   gain    The lpc model gain (rms prediction error)
%   a_      The lpc polynomial (without the 1 term)
%   acCos   The vector of autocorrelation coefficients

    L = length(frameDots);
    acCos = zeros(order + 1, 1);
    for i = 0 : order
        acCos(i + 1) = sum(frameDots(1 : L - i) .* frameDots(1 + i : L));
    end
    R = toeplitz(acCos(1 : order));
    a_ = R \ acCos(2 : order + 1);
    a = [1; -a_];
    gain = sqrt(sum(a .* acCos));

end




