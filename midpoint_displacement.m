function Z = initial_conditions_midpoint_displacement(x_max, y_max, max_height)
    % Initialize corners
    Z = zeros(x_max, y_max);
    Z(x_max, 1) = max_height / 2;
    Z(x_max, end) = max_height / 2;
    Z(1, y_max) = max_height / 2;
    Z(end, y_max) = max_height / 2;
    
    Z = divide(Z, x_max, y_max, x_max, y_max, max_height);
end

function height_map = divide(Z, x_size, y_size, x_max, y_max, scale)
    RNG_SEED = 2112;    
    
    RECURSION_SCALE_FACTOR = 1.8;
    ROUGHNESS_FACTOR = 0.75;
    
    x_mid = ceil(x_size / 2);
    y_mid = ceil(y_size / 2);
    scale = scale * ROUGHNESS_FACTOR;
    height_map = Z;

    if min([x_mid, y_mid]) < 1
        return
    end
    
    % for consistent random number generation across simulations
    rng(RNG_SEED + min([x_mid, y_mid]));
    
    for j = y_mid:y_size:y_max
        for i = x_mid:x_size:x_max
            height_map = square(height_map, i, j, x_mid, y_mid, (rand() * scale * 2) - scale);
        end
    end

    for j = 1:y_mid:y_max
        x_start = mod((j + x_mid), x_size);
        if x_start == 0
            x_start = x_size;
        end
        for i = x_start:x_size:x_max
            height_map = diamond(height_map, i, j, x_mid, y_mid, (rand() * scale * 2) - scale);
        end
    end
    
    height_map = divide(height_map, floor(x_size / 2), floor(y_size / 2), x_max, y_max, scale / RECURSION_SCALE_FACTOR);
end

function height_map = square(Z, x, y, x_range, y_range, offset)
    values = [get(Z, x - x_range + 1, y - y_range + 1), get(Z, x - x_range + 1, y + y_range), get(Z, x + x_range, y - y_range + 1), get(Z, x + x_range, y + y_range)];
    valid = values(~isnan(values));
    avg = mean(valid);
    height_map = Z;
    height_map(x, y) = avg + offset;
end

function height_map = diamond(Z, x, y, x_range, y_range, offset)
    values = [get(Z, x, y - y_range + 1), get(Z, x, y + y_range), get(Z, x + x_range, y), get(Z, x - x_range + 1, y)];
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
