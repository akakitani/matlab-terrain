function Z = generate_from_img(img_filename, detail)
    [Z, map] = imread(img_filename);
    [Z, map] = gray2ind(Z, 256);
    Z = im2double(imresize(Z, [detail, detail]));
    Z = Z(:, :, 1);
    fprintf('Terrain generation finished.\n\n');
end
