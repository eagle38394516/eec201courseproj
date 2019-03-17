function [signalOut] ...
        = myDecoder(numOfFrames, numOfFrameDots, ...
                    ifVoice, gain, pitchArray, lpcCoeffs, ...
                    frameSize_ms, samplingRate, overlapProporation, handles)

    % Use audioData only to see the original wave for comparasion
                
    % The last frame cannot be computed
    samplesPerFrame = frameSize_ms / 1000 * samplingRate;
    samplesOfOverlap = frameSize_ms / 1000 * overlapProporation * samplingRate;
    signalOut = zeros(1, frameSize_ms / 1000 * numOfFrames * samplingRate);
    
    for frameIndex = 1 : numOfFrames - 1
        sampleBeginIndex = samplesPerFrame * (frameIndex - 1) + 1;
        sampleEndIndex = samplesPerFrame * frameIndex + samplesOfOverlap;
        if ifVoice(frameIndex)
            t = 0 : 1 / samplingRate : (numOfFrameDots - 1) / samplingRate;
            d = 0 : 1 / pitchArray(frameIndex) : 1;
            residFrame = pulstran(t, d, 'tripuls', 0.001);
            residFrame = residFrame + 0.01 * randn(1, numOfFrameDots);
            y = filter(sqrt(gain(frameIndex)), lpcCoeffs(:, frameIndex), residFrame);
        else
            y = normrnd(0, 1, [1, numOfFrameDots]) * gain(frameIndex);
        end
%         y = abs(ifft(fft(y) .* fft(hamming(numOfFrameDots)')));
        signalOut(sampleBeginIndex : sampleEndIndex) = y;
        
%         figure(1);
%         subplot 311; plot((1 : length(signalOut)) / samplingRate, signalOut);
%         subplot 312; plot(audioData(sampleBeginIndex : sampleEndIndex));
%         subplot 313; plot(y);
    end
    signalOut = signalOut / max(signalOut);
    plot(handles.axes3, (1 : length(signalOut)) / samplingRate, signalOut);
    
end

