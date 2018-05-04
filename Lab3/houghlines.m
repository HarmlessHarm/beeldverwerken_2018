function [lines] = houghlines ( im , h , thresh )
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
    [m_h, n_h] = size(h);
    [m_im, n_im] = size(im);
    
    rhomax = sqrt(m_im^2 + n_im^2);
    drho = 2 * rhomax / (m_h);
    dtheta = pi / n_h;
    
    [bwl, nregions] = bwlabel(h > thresh);
    imshow(im);
    lines = [];
    for n = 1: nregions
        mask = bwl == n ;                                       % Form a mask for each region .
        region = mask .* h ;                                    % Point - wise multiply mask by Hough Transform
        [row, col] = find(region == max(region(:)));             % to give you an image with just one region of
        
        theta = col * dtheta;                                     % the Hough Transform .
        rho = row * drho - rhomax;
        [x1, y1, x2, y2] = thetarho2endpoints(theta, rho, m_im, n_im);
        hold on
        plot([x1, x2], [y1, y2]);
        hold off 
        if rho ~= 0
            line = [rho*sin(theta), rho*-cos(theta), 1];
            lines = [lines;line];
        end
    end
end