function Z = dla(grid_max)
    DIRECTION_N = [0, 1];
    DIRECTION_NE = [1, 1];
    DIRECTION_E = [1, 0];
    DIRECTION_SE = [1, -1];
    DIRECTION_S = [0, -1];
    DIRECTION_SW = [-1, -1];
    DIRECTION_W = [-1, 0];
    DIRECTION_NW = [-1, 1];

    PROB_N = 0.125;
    PROB_NE = 0.25;
    PROB_E = 0.375;
    PROB_SE = 0.5;
    PROB_S = 0.625;
    PROB_SW = 0.75;
    PROB_W = 0.875;
    PROB_NW = 1.0;

    NUM_PARTICLES = ceil((grid_max ^ 2) * 2);

    % Initialize the grid
    Z = zeros(grid_max, grid_max);

    % Seed initial point
    root_x = ceil(grid_max / 2);
    root_y = ceil(grid_max / 2);
    Z(root_x, root_y) = 0;

    prev_coord = generate_start_pos(grid_max);
    for p = 1:NUM_PARTICLES
        x = 0;
        y = 0;
        while true
            r = rand();
            next_dir = [0, 0];
            if r <= PROB_N
                next_dir = DIRECTION_N;
            elseif r <= PROB_NE
                next_dir = DIRECTION_NE;
            elseif r <= PROB_E
                next_dir = DIRECTION_E;
            elseif r <= PROB_SE
                next_dir = DIRECTION_SE;
            elseif r <= PROB_S
                next_dir = DIRECTION_S;
            elseif r <= PROB_SW
                next_dir = DIRECTION_SW;
            elseif r <= PROB_W
                next_dir = DIRECTION_W;
            elseif r <= PROB_NW
                next_dir = DIRECTION_NW;
            end
            next_coord = prev_coord + next_dir;
            x = next_coord(1);
            y = next_coord(2);
            if (x <= 0 || x > grid_max || y <= 0 || y > grid_max)
                % If out of bounds, try again         
                continue;
            elseif Z(x, y) > 0
            % If we already visited this position, also try again
                break;
            else
            % Found a suitable spot
                break;
            end
        end
        Z(x, y) = Z(x, y) + 0.1;
        prev_coord = [x, y];
        if x == root_x && y == root_y
            prev_coord = generate_start_pos(grid_max);
        end
        render_gen_process_heatmap(Z, 'dla_', p, 20000);
    end
end

function [x, y] = generate_start_pos(grid_max)
    x = randi(grid_max, 1, 1);
    y = 1;
    if x == 1 || x == grid_max
        y = randi(grid_max, 1, 1);
    else
        r = rand();
        if r < 0.5
            y = 1;
        else
            y = grid_max;
        end
    end
end
