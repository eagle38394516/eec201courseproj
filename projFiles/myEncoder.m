function [numOfFrames, numOfFrameDots, ifVoice, gain, pitchArray, lpcCoeffs] ...
        = myEncoder(audioData, frameSize_ms, samplingRate, lpcOrder, overlapProporation, handles)

    % The last frame cannot be computed
    samplesPerFrame = frameSize_ms / 1000 * samplingRate;
    samplesOfOverlap = frameSize_ms / 1000 * overlapProporation * samplingRate;

    numOfFrames = floor(length(audioData) / samplesPerFrame);
    numOfFrameDots = samplesPerFrame + samplesOfOverlap;

    ifVoice = false(1, numOfFrames);
    pitchArray = zeros(1, numOfFrames);
    lpcCoeffs = zeros(lpcOrder + 1, numOfFrames);
    gain = zeros(1, numOfFrames);

    for frameIndex = 1 : numOfFrames - 1
        % Get frame dots.
        sampleBeginIndex = samplesPerFrame * (frameIndex - 1) + 1;
        sampleEndIndex = samplesPerFrame * frameIndex + samplesOfOverlap;
        frameDots = audioData(sampleBeginIndex : sampleEndIndex);

        % Get pitch
        pitchArray(frameIndex) = myPitch(frameDots, samplingRate);

        % LPC
        [lpcCoeffs(:, frameIndex), gain(frameIndex)] = myLPC(frameDots, lpcOrder);
        
        % Check if voice
        if isnan(gain(frameIndex)) || pitchArray(frameIndex) >= 500
            ifVoice(frameIndex) = false;
            pitchArray(frameIndex) = 0;
        else
            ifVoice(frameIndex) = true;
        end
    end
    
    stem(handles.axes2, ifVoice * 200, '.');
    set(handles.axes2, 'NextPlot', 'Add');
    plot(handles.axes2, pitchArray, '.-');
    set(handles.axes2, 'NextPlot', 'Replace');
    legend(handles.axes2, 'ifVoice', 'pitch');

end
