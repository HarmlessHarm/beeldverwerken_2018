function h = hough ( im , Thresh , nrho , ntheta )
    % HOUGH
    %
    % Function takes a grey scale image , constructs an edge map by applying
    % the Canny detector , and then constructs a Hough transform for finding
    % lines in the image .
    %
    % Usage : h = hough (im , Thresh , nrho , ntheta )
    %
    % arguments :
    % im - The grey scale image to be transformed
    % Thresh - A 2 -vector giving the upper and lower
    % hysteresis threshold values for edge ()
    % nrho - Number of quantised levels of rho to use
    % ntheta - Number of quantised levels of theta to use
    %
    % returns ;
    % h - The Hough transform
    
    [rows, cols] = size(im);
    
    rhomax = sqrt ( rows ^2 + cols ^2); % The maximum possible value of rho.
    drho = 2* rhomax /( nrho -1); % The increment in rho between successive
    % entries in the accumulator matrix .
    % Remember we go between + - rhomax .
    dtheta = pi / ntheta ; % The increment in theta between entries .
    thetas = [0: dtheta :( pi - dtheta )]; % Array of theta values across the
    % accumulator matrix .
    
    accum = zeros(nrho, ntheta);
    edges = edge(im, 'canny', Thresh);
    [row, col] = find(edges);
    size(row)
    
    rhos = col * sin(thetas) - row * cos(thetas);
    for i = 1:size(rhos,1)
        for j = 1:size(rhos,2)
            rho = rhos(i,j);
            theta = thetas(j);
            rhoindex = round ( rho / drho + nrho /2);
            thetaindex = round ( theta / dtheta + 1);
            accum(rhoindex, j) = accum(rhoindex, j) + 1;
        end
    end
    
    h = accum;
    return;
    
    % for each x and y of nonzero edge values :
    % for each theta in thetas :
    % rho = evaluate (1)
    % To convert a value of rho or theta
    % to its appropriate index in the array use:
    
            

end