function Z = midpoint_displacement(grid_max)
    % Initialize corners
    max_height = 1.0;
    rng('shuffle');
    Z = zeros(grid_max, grid_max);
    Z(1, 1) = (rand() * max_height * 2) - max_height;
    Z(end, 1) = (rand() * max_height * 2) - max_height;
    Z(1, end) = (rand() * max_height * 2) - max_height;
    Z(end, end) = (rand() * max_height * 2) - max_height;
    render_gen_process(Z, 'diamond_square_', grid_max + 1, 1);
    Z = divide(Z, grid_max, grid_max, max_height);
end

function height_map = divide(Z, grid_size, grid_max, max_height)
    ROUGHNESS_FACTOR = 1;
    half = ceil(grid_size / 2);
    scale = max_height * ROUGHNESS_FACTOR;
    height_map = Z;

    for j = half:grid_size - 1:grid_max
        for i = half:grid_size - 1:grid_max
            height_map = square(height_map, i, j, half - 1, (rand() * scale * 2) - scale);
        end
    end

    for j = 1:half - 1:grid_max
        i_start = mod((j + half - 1), grid_size - 1);
        if i_start == 0
            i_start = 1;
        end
        for i = i_start:grid_size - 1:grid_max
            height_map = diamond(height_map, i, j, half - 1, (rand() * scale * 2) - scale);
        end
    end

    render_gen_process(height_map, 'diamond_square_', grid_size, 1);

    if (half / 2) < 1
        return
    end

    height_map = divide(height_map, half, grid_max, max_height / 2);
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

function val = get(Z, x, y)
    [X, Y] = size(Z);
    if x < 1 || y < 1 || x > X || y > Y
        val = NaN;
    else
        val = Z(x, y);
    end
end
