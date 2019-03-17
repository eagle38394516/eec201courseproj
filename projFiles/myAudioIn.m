function [audioData] = myAudioIn(filename, samplingRate)

    [data, fs] = audioread(filename);

    sizeOFData = size(data);
    if sizeOFData(2) == 2
        data(:, 2) = [];
    end

    audioData = resample(data, samplingRate, fs);

end
