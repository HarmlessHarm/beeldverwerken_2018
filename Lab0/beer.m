function beer(x)
    for i=1:size(x,2)
        if mod(x(i),1) == 0
            sprintf('%u bottle(s) of beer on the wall', x(i))
        end
    end
end
