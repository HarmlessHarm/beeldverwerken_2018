function new_cube = transformFaces(M, faces)

    new_cube = zeros(3,5,6);
    new_faces= zeros(4,5,6);
    for i=1:6
        new_faces(:,:,i) = [faces(:,:,i);ones(1,size(faces,2),1)];
        new_cube(:,:,i) = M * new_faces(:,:,i);
        new_cube(:,:,i) = new_cube(:,:,i) ./ new_cube(3,:,i);
    end
    return;
end