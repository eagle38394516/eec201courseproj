function framePitch = myPitch(frameDots, samplingRate)

    frame_len = length(frameDots);

    % Use xcorr to determine the local period of the frame
    [rxx, ~] = xcorr(frameDots, frameDots);

    % Set any negative correlation values to zero
    rxx(rxx < 0) = 0;

    %Find the first zero after center
    center_peak_width = find(rxx(frame_len : end) == 0, 1);

    % Center of rxx is located at length(frame) + 1
    rxx(frame_len - center_peak_width : frame_len + center_peak_width) = min(rxx);

    [~, loc] = max(rxx);
    period = abs(loc - length(frameDots) + 1);

    framePitch = samplingRate / period;
end