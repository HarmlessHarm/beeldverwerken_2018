i = im2double(rgb2gray(imread('attachments/billboard.png')));



bw = edge(i, 'canny');
subplot(1,2,1)
imshow(bw)
subplot(1,2,2)
imshow(i)

[row,col] = find(bw);

size(row)