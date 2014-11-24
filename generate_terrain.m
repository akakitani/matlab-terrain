function heightmap = generate_terrain(size, gen_function)
    grid_size = (2 ^ size) + 1;
    max_height = grid_size;
    heightmap = gen_function(grid_size, max_height);
    fprintf('Terrain generation finished.\n\n');
end
