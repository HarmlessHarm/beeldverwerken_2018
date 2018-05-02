function houghlines ( im , h , thresh )
% HOUGHLINES
%
% Function takes an image and its Hough transform , finds the
% significant lines and draws them over the image
%
% Usage : houghlines (im , h, thresh )
%
% arguments :
% im - The original image
% h - Its Hough Transform
% thresh - The threshold level to use in the Hough Transform
% to decide whether an edge is significant
    ...
    for n = 1: nregions
        mask = bwl == n ;       % Form a mask for each region .
        region = mask .* h ;    % Point - wise multiply mask by Hough Transform
                                % to give you an image with just one region of
                                % the Hough Transform .

    end
end