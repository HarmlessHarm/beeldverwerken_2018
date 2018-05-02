%% Lab 2
% Team: Harm Manders, Hannah Min
clc
disp('Lab 2 by Harm Manders and Hannah Min')

%% 1 Convolution Examples and Implementation
i = im2double(imread( 'autumn.tif'));
figure(1)
subplot(2,2,1)
imshow(i)
title('original')

intens = [3];
intensI = imfilter(i, intens, 'conv', 'replicate');
subplot(2,2,2)
imshow(intensI);
title('3x more intense')

gau = fspecial('gaussian', 5,2);
ident = zeros(5);
ident(3,3) = 2;
sharp = ident - gau;
sharpI = imfilter(i, sharp, 'conv', 'replicate');
subplot(2,2,3)
imshow(sharpI)
title('sharpen')

subplot(2,2,4)
blurI = imfilter(i, gau, 'conv', 'replicate');
imshow(blurI)
title('blur')

%% 2 Gaussian convolution
sum(sum(gauss(2)))
sum(sum(gauss(9)))
% We expect the sum to approximate 1 and this is true.
figure(2)
% 3D-plot of gauss
subplot(1,2,1)
mesh(gauss(3));
title('3D-gauss sigma=3')

% Sigma states how data is distributed about the mean. To determine the
% size of our gauss grid, we chose 2.5 times sigma in both directions of
% the origin because this covers 99% of the data, and we need the sum of
% the grid also to be one.

% Timing tests for different sigmas
i = im2double(imread('autumn.tif'));
times = zeros(1,10);
n=100;
for s = 1:20
    g = gauss(s);
    endTime = 0;
    for i = 1:n
        tic;
        imfilter(i, g, 'conv', 'replicate');
        t = toc;
        endTime = endTime + t;
    end
    times(s) = endTime / n;
end

subplot(1,2,2)
plot(times);
title('Time against scale')

% The order of computational complexity in terms of the scale sigma seems 
% to be linear.
% This would mean that performing a gaussian convolution of 5 and 10 in 
% sequence would take just as much time as performing a gaussion 
% convolution of 15 at once.

g5 = gauss(5);
g10 = gauss(10);
g15 = gauss(15);

disp('gauss(5) then gauss(10):')
tic;
imfilter(i, g5, 'conv', 'replicate');
imfilter(i, g10, 'conv', 'replicate');
toc

disp('gauss(15):')
tic;
imfilter(i, g15, 'conv', 'replicate');
toc
%% 1D Gauss
i_b = imfilter(i, gauss1(5), 'conv', 'replicate');
i_b = imfilter(i_b, gauss1(5)', 'conv', 'replicate');

i_a = imfilter(i, gauss(5), 'conv', 'replicate');
% MSE for 2D gauss and 2x1D gauss
sum(sum((i_a - i_b)^2))

i = im2double(imread('autumn.tif'));
times = zeros(1,10);
n=100;
for s = 1:20
    g = gauss1(s);
    gt = g';
    endTime = 0;
    for i = 1:n
        tic;
        i_b = imfilter(i, g, 'conv', 'replicate');
        imfilter(i_b, gt, 'conv', 'replicate');
        t = toc;
        endTime = endTime + t;
    end
    times(s) = endTime / n;
end
subplot(1,2,2)
hold on
plot(times)
hold off

% The computational complexity is now constant.
%% 2-Jet

i = im2double(imread('cameraman.tif'));

fx = gD(i, 3, 1, 0);
fy = gD(i, 3, 0, 1);
fxx = gD(i, 3, 2, 0);
fyy = gD(i, 3, 0, 2);
fxy = gD(i, 3, 1, 1);

figure(3)
subplot(2,3,1)
imshow(i)
title('original')
subplot(2,3,2)
imshow(fx,[])
title('fx')
subplot(2,3,3)
imshow(fy,[])
title('fy')
subplot(2,3,4)
imshow(fxx,[])
title('fxx')
subplot(2,3,5)
imshow(fxy,[])
title('fxy')
subplot(2,3,6)
imshow(fyy,[])
title('fyy')


%% The Canny Edge Detector

x = -100:100;
y = -100:100;
[X , Y ] = meshgrid (x , y );
A = 1; B = 2; V = 6* pi /201; W = 4* pi /201;
F = A * sin ( V * X ) + B * cos ( W * Y );
% Afgeleides
Fx = A * V *cos(V * X);
Fy = -B * W * sin(W * Y);
Fxx = -A * V^2 * sin(V * X);
Fyy = -B * W^2 * cos(W * Y);
Fxy = 0;


%%
xx = -100:10:100;
yy = -100:10:100;
figure(4)
subplot(1,2,1)
imshow (F , [] , 'xData', x , 'yData' , y );
hold on ;
quiver ( xx , yy, Fx(xx+101,yy+101), Fy(xx+101,yy+101) , 'r');
hold off ;
%%
S = 1;
Gx = gD(F, S, 1, 0);
Gy = gD(F, S, 0, 1);
Gxx = gD(F, S, 2, 0);
Gyy = gD(F, S, 0, 2);
Gxy = gD(F, S, 1, 1);
subplot(1,2,2)
imshow (F , [] , 'xData', x , 'yData' , y );
hold on ;
quiver ( xx , yy, Gx(xx+101,yy+101), Gy(xx+101,yy+101) , 'b');
hold off ;
%%
subplot(2,3,1)
imshow (F , [] , 'xData' , x , 'yData' , y );
subplot(2,3,2)
imshow (Fx , [] , 'xData' , x , 'yData' , y );
subplot(2,3,3)
imshow (Fy , [] , 'xData' , x , 'yData' , y );
subplot(2,3,4)
imshow (Fxx , [] , 'xData' , x , 'yData' , y );
subplot(2,3,5)
imshow (Fxy , [] , 'xData' , x , 'yData' , y );
subplot(2,3,6)
imshow (Fyy , [] , 'xData' , x , 'yData' , y );

%%

R = rotateImage(F, deg2rad(10),'linear', 'const');
RGx = gD(R, S, 1, 0);
RGy = gD(R, S, 0, 1);
% subplot(1,3,3)
rr = -115:10:115;
imshow (R , [] , 'xData', x , 'yData' , y );
hold on ;
quiver ( rr , rr, RGx(rr+116,rr+116), RGy(rr+116,rr+116) , 3, 'b');
hold off ;


