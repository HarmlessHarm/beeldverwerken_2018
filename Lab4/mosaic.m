function mosaic(xy, xaya, f1, f2) 

    % Generate normalised projection matrix and create a Tform struct
    T = createProjectionMatrix(xy', xaya');
    A = T' ./ T(end, end);
    T = maketform('projective', A);
    [x, y] = tformfwd(T,[1 size(f1,2)], [1 size(f1,1)]);

    xdata = [min(1,x(1)) max(size(f2,2),x(2))];
    ydata = [min(1,y(1)) max(size(f2,1),y(2))];
    f12 = imtransform(f1,T,'Xdata',xdata,'YData',ydata);
    f22 = imtransform(f2, maketform('affine', [1 0 0; 0 1 0; 0 0 1]), 'Xdata',xdata,'YData',ydata);
    imshow(max(f12,f22));

end