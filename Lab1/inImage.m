function inImage = inImage(dims, x, y)
    inImage = false;
    if (x >= 1 && x <= dims(1)) && (y >= 1 && y <= dims(2))
        inImage = true;
    end
    return;
end