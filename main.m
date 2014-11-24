clear
clf reset
cla reset

SIZE_LEVEL = 4;
DETAIL_LEVEL = 5;
WATER_LEVEL = 0.25;
Z_ASPECT_RATIO = 0.1;

%heightmap = generate_terrain(SIZE_LEVEL, @midpoint_displacement);
heightmap = generate_from_img('cat.jpg', 256);
render(heightmap, DETAIL_LEVEL, WATER_LEVEL, Z_ASPECT_RATIO)
