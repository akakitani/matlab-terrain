clear
clf reset
cla reset

%{
SIZE_LEVEL = 6;
DETAIL_LEVEL = 20;
WATER_LEVEL = 0.45;
Z_ASPECT_RATIO = 0.1;
SMOOTHING = false;
heightmap = generate_terrain(SIZE_LEVEL, @midpoint_displacement);
render(heightmap, DETAIL_LEVEL, WATER_LEVEL, Z_ASPECT_RATIO, SMOOTHING)
%}

SIZE_LEVEL = 9;
DETAIL_LEVEL = 1;
WATER_LEVEL = 0.1;
Z_ASPECT_RATIO = 0.01;
SMOOTHING = true;
heightmap = generate_terrain(SIZE_LEVEL, @dla);
render(heightmap, DETAIL_LEVEL, WATER_LEVEL, Z_ASPECT_RATIO, SMOOTHING)


%{
DETAIL_LEVEL = 5;
WATER_LEVEL = 0.25;
Z_ASPECT_RATIO = 0.05;
SMOOTHING = false;

heightmap = generate_from_img('terrain.jpg', 256);
render(heightmap, DETAIL_LEVEL, WATER_LEVEL, Z_ASPECT_RATIO, SMOOTHING)
%}
