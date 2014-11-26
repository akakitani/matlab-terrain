function Z = midpoint_displacement(grid_max, max_height)
    % Initialize corners
    rng('shuffle');
    Z = zeros(grid_max, grid_max);
    Z(1, 1) = 0;
    Z(end, 1) = 0;
    Z(1, end) = 0;
    Z(end, end) = 0;
    Z = divide(Z, grid_max, max_height);
end

function height_map = divide(Z, grid_size, grid_max)
    ROUGHNESS_FACTOR = 0.3;

    half = ceil(grid_size / 2);
    scale = grid_size * ROUGHNESS_FACTOR;
    height_map = Z;

    if half <= 1
        return
    end

    for j = half:grid_size:grid_max
        for i = half:grid_size:grid_max
            height_map = square(height_map, i, j, half, (rand() * scale * 2) - scale);
        end
    end
    for j = 1:half:grid_max
        i_start = mod((j - 1 + half), grid_size);
        if i_start == 0
            i_start = 1;
        end
        for i = i_start:grid_size:grid_max
            height_map = diamond(height_map, i, j, half, (rand() * scale * 2) - scale);
        end
    end
    height_map = divide(height_map, half, grid_max);
end

function height_map = square(Z, x, y, grid_size, offset)
    values = [
        get(Z, x - grid_size, y - grid_size),
        get(Z, x - grid_size, y + grid_size),
        get(Z, x + grid_size, y - grid_size),
        get(Z, x + grid_size, y + grid_size)
    ];
    valid = values(~isnan(values));
    avg = mean(valid);
    height_map = Z;
    height_map(x, y) = avg + offset;
end

function height_map = diamond(Z, x, y, grid_size, offset)
    values = [
        get(Z, x, y - grid_size),
        get(Z, x, y + grid_size),
        get(Z, x + grid_size, y),
        get(Z, x - grid_size, y)
    ];
    valid = values(~isnan(values));
    avg = mean(valid);
    height_map = Z;
    height_map(x, y) = avg + offset;
end

function x = get(Z, x, y)
    [X, Y] = size(Z);
    if x < 1 || y < 1 || x > X || y > Y
        x = NaN;
    else
        x = Z(x, y);
    end
end
