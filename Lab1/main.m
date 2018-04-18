function main()

    %% Exercise 1
    % Team: Harm Manders, Hannah Min
 
    %% Question 2
    a = imread( 'autumn.tif' );
    a = im2double( rgb2gray (a) );
    
    subplot( 2, 3, 1)
    hold on;
    plot( profile (a, 100, 100, 120, 120, 200, 'linear'), 'b');
    plot( profile (a, 100, 100, 120, 120, 200, 'nearest'), 'r');
    hold off;
    title('Question 2')
    xlabel('200 samples')
    
    % In pixelValue you can now use 'const', 'edge' and 'modulo'
    % to define what kind of border you  want to generate.
    
    %% Question 3
    i = im2double(imread('cameraman.tif'));
    t = deg2rad(45);
    
    
    calcDistance(i,t,'linear')
    calcDistance(i,t,'nearest')
    
    %% Question 4
    i = im2double(imread('cameraman.tif'));
    myAffine(i, -53,128, 128,-53, 128,309, 256,256,'nearest');
    
    %% Question 5
    
    i = im2double(imread('attachments/flyers.png'));
    imshow(i)
%     xy = ginput(4)
%     xy = [xy(:,2), xy(:,1)]
    xy = [187.5130  571.3468;
          170.5571  818.7026;
          588.4688  595.2844;
          555.5545  350.9208];

    myProjection(i, xy, 400, 300, 'nearest');
end
