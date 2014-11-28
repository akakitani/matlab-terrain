function Z = smooth(heightmap, detail_level, param_arr)
    detail = 1 / detail_level;
    [size_x, size_y] = size(heightmap);   
    
    [X, Y] = meshgrid(1:size_x, 1:size_y);
    [Xq, Yq] = meshgrid(1:detail:size_x, 1:detail:size_y);

    interpolated_heightmap = interp2(X, Y, heightmap, Xq, Yq);
    interp_size = size(interpolated_heightmap);
    heightmap_arr = zeros(interp_size(1), interp_size(2), size(param_arr, 2));

    for i = 1:size(param_arr, 2)
        filter_param = param_arr(i);
        h = fspecial('gaussian', ceil(size(interpolated_heightmap)), filter_param);
        heightmap_arr(:, :, i) = imfilter(interpolated_heightmap, h);
        render_smooth_process(heightmap_arr(:, :, i), 'smoothing_', i, 1);
    end
    
    Z = sum(heightmap_arr, 3);
    Z = (Z - min(Z(:))) ./ (max(Z(:) - min(Z(:))));
    render_smooth_process(Z, 'smoothing_sum', 1, 1);
end