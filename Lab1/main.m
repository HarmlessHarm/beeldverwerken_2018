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
    
    % In pixelValue you can now use 'const', 'nearest' and 'modulo'
    % to define what kind of border you  want to generate.
    
    %% Question 3
    i = im2double(imread('cameraman.tif'));
    t = deg2rad(1);
    
    
    calcDistance(i,t,'linear')
    calcDistance(i,t,'nearest')
    
end
