clear
clf

SIZE_LEVEL = 4;
DETAIL_LEVEL = 5;
WATER_LEVEL = 0.3;

heightmap = generate_terrain(SIZE_LEVEL, @midpoint_displacement);
render(heightmap, DETAIL_LEVEL, 0.3)
