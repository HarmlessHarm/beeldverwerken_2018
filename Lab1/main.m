function main()

    %% Lab 1
    % Team: Harm Manders, Hannah Min
    clc
    disp('Lab 1 by Harm Manders and Hannah Min')
 
    %% Question 2
    a = imread( 'autumn.tif' );
    a = im2double( rgb2gray (a) );
    figure('NumberTitle', 'off','Name', 'Questions 2 till 5');
    subplot( 2, 3, 1)
    hold on;
    plot( profile (a, 100, 100, 120, 120, 200, 'linear'), 'b');
    plot( profile (a, 100, 100, 120, 120, 200, 'nearest'), 'r');
    hold off;
    title('Q2: profile')
    xlabel('200 samples')
    
    % With the addBorder function you can pass 'const' and 'edge'
    % to define what kind of border you  want to generate.
    % The size of the border depends on how far you rotate.
    subplot(2,3,2);
    imshow(addBorder(a, deg2rad(10), 'edge'));
    title('Q2: Border');
    xlabel('nearest neighbour');
    
    %% Question 3
    i = im2double(imread('cameraman.tif'));
    t = deg2rad(30);
    subplot(2,3,3);
    imshow(rotateImage(i, t, 'linear', 'const'));
    title('Q3: Rotate');
    xlabel('30deg counter clock');
    
    % Time it takes to rotate and interpolate an image
    % Linear vs nearest neighbour interpolation
    disp('------------------');
    disp('Q3: timing');
    disp('linear:');
    tic
    rotateImage(i, t, 'linear', 'const');
    toc
    disp('nearest:');
    tic
    rotateImage(i, t, 'nearest', 'const');
    toc
    disp('------------------');

    % Distance between images, one rotated twice back and forth and the
    % a bordered version of the image.
    l =  calcDistance(i,t,'linear');
    n = calcDistance(i,t,'nearest');
    disp('Q3: distance of images');
    fprintf('linear: %d \n', round(l));
    fprintf('nearest: %d \n', round(n));
    
    
    %% Question 4
    i = im2double(imread('cameraman.tif'));
    % Coordinates needed for rotation around center by 45 deg.
    a = myAffine(i, -53,128, 128,-53, 128,309, 256,256,'linear');
    subplot(2,3,4);
    imshow(a);
    title('Q4: Rotate with affine');
    subplot(2,3,5);
    % This plot is overwritten but can be plotted if wanted.
    imshow(i);
    plotParallelogram(-53,128, 128,-53, 128,309);
    
    %% Question 5
    
    i = im2double(imread('attachments/flyers.png'));
    % Predefined images, coordinates acquired with ginput(4)
    xy = [571,188;822,173;593,587;354,556]; 
    proj1 = myProjection(i, xy, 400,300, 'linear');
    xy = [148,590; 102,373; 304,208; 390,395];
    proj2 = myProjection(i, xy, 300,400, 'linear');

    subplot(2,3,5)
    imshow(proj1)
    title('Q5: Projective transformation')
    subplot(2,3,6)
    imshow(proj2)
    title('Q5: Projective transformation')

     % Uncomment lines below to use user input
%     figure(2);
%     subplot(1,3,[1,2]);
%     imshow(i);
%     xy = ginput(4);
%     projUser = myProjection(i, xy, 400,300, 'linear');
%     subplot(1,3,3);
%     imshow(projUser);
    
    %% Question 7
    i = im2double(imread('attachments/calibrationpoints.jpg'));
    figure('NumberTitle', 'off','Name', 'Question 7 and 8.1')
    imshow(i);
    title('Q7 & Q8: Pseudo 3D projections');
    load('attachments/calibrationpoints.mat');
    P = estimateProjectionMatrix(xy, XYZ);
    text(xy(:,1)-4,xy(:,2), '+', 'FontSize', 10, 'FontWeight', 'bold')
    
    %% Question 8.1
    % Rewritten the predefined function createCube and subPlotfaces so it
    % would work better and more optimized.
    cubes = [[0,0,0];[5.5,0,3];[0,7,6]];
    for i=1:3
        faces = createCube(1, cubes(i,:)');
        new_faces = transformFaces(P, faces);
        new_faces(3,:,:) = [];
        subPlotFaces(new_faces);
    end

    %% Question 8.2
    
    figure('NumberTitle', 'off', 'Name', 'Question 8.2');
    load('attachments/calibrationpoints.mat');
    cubes = [[0,0,0.5];[5,0,3];[0,7,6.5]];
    for i=1:4
        im = im2double(imread(sprintf('attachments/view%d.jpg',i)));
        load(sprintf('attachments/view%d.mat',i));
        subplot(2,2,i)
        imshow(im);
        P = estimateProjectionMatrix(xy, XYZ);
        for j = 1:3
            faces = createCube(1,cubes(j,:)');
            new_faces = transformFaces(P, faces);
            new_faces(3,:,:) = [];
            subPlotFaces(new_faces);
        end
    end




end
