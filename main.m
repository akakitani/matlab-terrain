function main(algorithm)
    % Global configs
    global WRITE_TO_FILE;
    WRITE_TO_FILE = false;

    % Keys for options hash passed into terrain gen function
    global TERRAIN_FUNCTION SIZE_LEVEL IMAGE_FILENAME;
    global FILTER_DETAIL_LEVEL FILTER_RADIUS_PARAMS;
    global DETAIL_LEVEL WATER_LEVEL Z_ASPECT_RATIO;

    TERRAIN_FUNCTION = 'TERRAIN_FUNCTION';
    SIZE_LEVEL = 'SIZE_LEVEL';
    IMAGE_FILENAME = 'IMAGE_FILENAME';
    FILTER_DETAIL_LEVEL = 'FILTER_DETAIL_LEVEL';
    FILTER_RADIUS_PARAMS = 'FILTER_RADIUS_PARAMS';
    DETAIL_LEVEL = 'DETAIL_LEVEL';
    WATER_LEVEL = 'WATER_LEVEL';
    Z_ASPECT_RATIO = 'Z_ASPECT_RATIO';

    switch algorithm
        case 'midpoint_displacement'
            midpoint_displacement_opts = containers.Map;
            midpoint_displacement_opts(TERRAIN_FUNCTION) = @midpoint_displacement;
            midpoint_displacement_opts(SIZE_LEVEL) = 8;
            midpoint_displacement_opts(FILTER_DETAIL_LEVEL) = 1;
            midpoint_displacement_opts(FILTER_RADIUS_PARAMS) = [2, 4, 8, 16];
            midpoint_displacement_opts(DETAIL_LEVEL) = 10;
            midpoint_displacement_opts(WATER_LEVEL) = 0.1;
            midpoint_displacement_opts(Z_ASPECT_RATIO) = 0.01;

            generate_terrain(midpoint_displacement_opts);
        case 'random_walk'
            random_walk_opts = containers.Map;
            random_walk_opts(TERRAIN_FUNCTION) = @random_walk;
            random_walk_opts(SIZE_LEVEL) = 9;
            random_walk_opts(FILTER_DETAIL_LEVEL) = 2;
            random_walk_opts(FILTER_RADIUS_PARAMS) = [2, 4, 8, 16, 32, 64, 128, 256];
            random_walk_opts(DETAIL_LEVEL) = 1;
            random_walk_opts(WATER_LEVEL) = 0.05;
            random_walk_opts(Z_ASPECT_RATIO) = 0.01;

            generate_terrain(random_walk_opts);
        case 'heightmap'
            heightmap_opts = containers.Map;
            heightmap_opts(TERRAIN_FUNCTION) = @generate_from_img;
            heightmap_opts(IMAGE_FILENAME) = 'heightmap/terrain.jpg';
            heightmap_opts(SIZE_LEVEL) = 8;
            heightmap_opts(DETAIL_LEVEL) = 10;
            heightmap_opts(WATER_LEVEL) = 0;
            heightmap_opts(Z_ASPECT_RATIO) = 0.05;

            generate_terrain(heightmap_opts);
        case 'galaxy'
            galaxy_opts = containers.Map;
            galaxy_opts(TERRAIN_FUNCTION) = @generate_from_img;
            galaxy_opts(IMAGE_FILENAME) = 'galaxy/galaxy.jpg';
            galaxy_opts(SIZE_LEVEL) = 8;
            galaxy_opts(FILTER_DETAIL_LEVEL) = 2;
            galaxy_opts(FILTER_RADIUS_PARAMS) = [2, 4, 8, 16, 32, 64, 128];
            galaxy_opts(DETAIL_LEVEL) = 10;
            galaxy_opts(WATER_LEVEL) = 0.2;
            galaxy_opts(Z_ASPECT_RATIO) = 0.01;

            generate_terrain(galaxy_opts);
        case 'cloud'
            cloud_opts = containers.Map;
            cloud_opts(TERRAIN_FUNCTION) = @generate_from_img;
            cloud_opts(IMAGE_FILENAME) = 'cloud/cloud.jpg';
            cloud_opts(SIZE_LEVEL) = 8;
            cloud_opts(FILTER_DETAIL_LEVEL) = 2;
            cloud_opts(FILTER_RADIUS_PARAMS) = [2, 4, 8, 16, 32, 64];
            cloud_opts(DETAIL_LEVEL) = 10;
            cloud_opts(WATER_LEVEL) = 0.2;
            cloud_opts(Z_ASPECT_RATIO) = 0.01;

            generate_terrain(cloud_opts);
        otherwise
            fprintf('Usage: main(<terrain_generation_type>)\n');
            fprintf('<terrain_generation_type> is can be one of the following strings:\n');
            fprintf('\t ''midpoint_displacement'' -- midpoint displacement algorithm\n');
            fprintf('\t ''random_walk'' -- random walk algorithm\n');
            fprintf('\t ''heightmap'' -- uses heightmap image of actual terrain\n');
            fprintf('\t ''galaxy'' -- uses image of Milky Way as heightmap\n');
            fprintf('\t ''cloud'' -- uses image of clouds as heightmap\n');
    end
end


function generate_terrain(opts)
    global TERRAIN_FUNCTION SIZE_LEVEL IMAGE_FILENAME
    global FILTER_DETAIL_LEVEL FILTER_RADIUS_PARAMS
    global DETAIL_LEVEL WATER_LEVEL Z_ASPECT_RATIO;

    terrain_function = opts(TERRAIN_FUNCTION);
    grid_size = (2 ^ opts(SIZE_LEVEL)) + 1;
    if isequal(terrain_function, @generate_from_img)
        Z = generate_from_img(opts(IMAGE_FILENAME), grid_size);
    else
        Z = terrain_function(grid_size);
    end
    fprintf('Terrain generation finished.\n\n');

    if opts.isKey(FILTER_DETAIL_LEVEL) && opts.isKey(FILTER_RADIUS_PARAMS)
        Z = smooth(Z, opts(FILTER_DETAIL_LEVEL), opts(FILTER_RADIUS_PARAMS));
        fprintf('Smoothing finished.\n\n');
    end

    render(Z, opts(DETAIL_LEVEL), opts(WATER_LEVEL), opts(Z_ASPECT_RATIO));
    fprintf('Terrain rendering finished.\n\n');
end
