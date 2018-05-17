% script to demonstrate image mosaic
% by handpicking 4 matching points
% in the order topleft - topright - bottomright - bottomleft
addpath('attachments/')
f1 = imread('nachtwacht1.jpg');
f2 = imread('nachtwacht2.jpg');

xy = [151.1505  199.3075  222.3206  222.3206;
    75.3374  129.8869  108.5785   57.4383];

xaya = [13.0421   67.7710   82.3654   69.5953;
    75.1542  110.2720   87.0121   41.8607];

%[xy, xaya] = pickmatchingpoints(f1, f2, 4, 1)

T = createProjectionMatrix(xy', xaya');
A = T' ./ T(end, end);
T = maketform('projective', A);
% T = maketform('projective', xy', xaya');
[x, y] = tformfwd(T,[1 size(f1,2)], [1 size(f1,1)]);

xdata = [min(1,x(1)) max(size(f2,2),x(2))];
ydata = [min(1,y(1)) max(size(f2,1),y(2))];
f12 = imtransform(f1,T,'Xdata',xdata,'YData',ydata);
f22 = imtransform(f2, maketform('affine', [1 0 0; 0 1 0; 0 0 1]), 'Xdata',xdata,'YData',ydata);
subplot(1,1,1);
imshow(max(f12,f22));