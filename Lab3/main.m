shap = im2double(rgb2gray(imread('attachments/shapes.png')));
box = im2double(rgb2gray(imread('attachments/box.png')));
bill = im2double(rgb2gray(imread('attachments/billboard.png')));
szel = im2double(rgb2gray(imread('attachments/szeliski.png')));


%% 2: Finding Lines using the Hough Transform


thresh_min = 0.2;
thresh_max = 0.6;
ntheta = 200;
nrho = 200;


[h, coords] = hough(shap, [thresh_min, thresh_max], nrho, ntheta);
e = edge(shap, 'Canny', [thresh_min, thresh_max]);

figure(1);
subplot(2,3,1);
imshow(shap);
subplot(2,3,2);
imshow(e);
subplot(2,3,3);
imshow(h,[])

[h, coords] = hough(szel, [thresh_min, thresh_max], nrho, ntheta);
e = edge(szel, 'Canny', [thresh_min, thresh_max]);

figure(1);
subplot(2,3,4);
imshow(szel);
subplot(2,3,5);
imshow(e);
subplot(2,3,6);
imshow(h, [])


%% 3: Finding the Lines as Local Maxima

figure(2)

subplot(1,2,1)
lines = houghlines(szel, h, 175);
title('Opdracht 3')

%% 5: Optimal Line Estimation


epsilon = 7;
subplot(1,2,2)
imshow(szel)
title('Opdracht 5')

% Draw points that correspond to line n
n =2
line_points = points_of_line(coords, lines(n,:), epsilon);
hold on
plot(line_points(:, 1), line_points(:, 2), '*')
hold off

new_lines = zeros(length(lines), 3);
for i = 1:length(lines)
   line_points = points_of_line(coords, lines(i,:), epsilon);
   new_lines(i,:) = line_through_points(line_points);
end

%% 6: 
figure(3)
I = im2double(rgb2gray(imread('attachments/szeliski.png')));
[h, pts] = hough(I, [0.2,0.6], 200, 200);
h = h ./ max(h(:));
lines = houghlines(I, h, 0.5);
subplot(2,1,1);
imshow(I)
nl = zeros(length(lines), 3);
for i = 1:length(lines)
   line_points = points_of_line(coords, lines(i,:), epsilon);
   nl(i,:) = line_through_points(line_points);
end

intersections = zeros(4, 3);

intersections(1,:) = cross(nl(1,:), nl(4,:));
intersections(1,:)= intersections(1,:) ./ intersections(1,3);

intersections(2,:) = cross(nl(2,:), nl(4,:));
intersections(2,:)= intersections(2,:) ./ intersections(2,3);

intersections(3,:) = cross(nl(2,:), nl(3,:));
intersections(3,:)= intersections(3,:) ./ intersections(3,3);

intersections(4,:) = cross(nl(1,:), nl(3,:));
intersections(4,:)= intersections(4,:) ./ intersections(4,3);

hold on
plot(intersections(:,1), intersections(:,2), '*')
hold off
subplot(2,1,2)

p = myProjection(I,intersections(:,1:2), 400,300 , 'linear');
imshow(p)
