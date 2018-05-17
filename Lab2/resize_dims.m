function [mDiff, nDiff] = resize_dims(m, n, angle)
    
    corners = [1,1,m+1,m+1;
               1,n+1,1,n+1];
  
    
    R = [cos(angle), -sin(angle);
         sin(angle), cos(angle)];
     
    new_corn = R * corners;

    maxM = max(new_corn(1,:));
    minM = min(new_corn(1,:));
    maxN = max(new_corn(2,:));
    minN = min(new_corn(2,:));
    
    mDiff = round(maxM - minM);
    nDiff = round(maxN - minN);
    return;
    
end