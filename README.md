# Matlab Terrain Generation

Final project for Earth and Planetary Science 109

Use `main.m` to run. Call `main(<terrain_generation_type>)`, where `<terrain_generation_type>` can be one of
the following strings:
```
'midpoint_displacement' -- midpoint displacement algorithm
'random_walk' -- random walk algorithm
'heightmap' -- uses heightmap image of actual terrain
'galaxy' -- uses image of Milky Way as heightmap
'cloud' -- uses image of clouds as heightmap
 ```

Parameters used in terrain generation (not all of these are used in every algroithm):
 * `SIZE_LEVEL` - size of the generated heightmap - the resulting size is `2 ^ SIZE_LEVEL`
 * `IMAGE_FILENAME` - for terrain that uses an image file, this is the path to the image file to use rooted at where `main.m` is
 * `FILTER_DETAIL_LEVEL` - interpolation to use before Gaussian smoothing - a `FILTER_DETAIL_LEVEL` of 2 will interpolate an `n x n` grid to a `2n x 2n` grid
 * `FILTER_RADIUS_PARAMS` - a list of radius parameters to use for the Gaussian smoothing. For best results, make them increase exponentially
 * `DETAIL_LEVEL` - interpolation to use for the final rendering of the terrain
 * `WATER_LEVEL` - what the water level is in the final terrain. Must be between 0 and 1
 * `Z_ASPECT_RATIO` - the aspect ratio to use on the rendered terrain on the Z axis. The X and Y axes are set to an aspect ratio of 1

The actual terrain generation algorithms are in `mindpoint_displacement.m`, `random_walk.m`, and `generate_from_img.m`.

The Gaussian smoothing logic is in `smooth.m`.

The `render_*.m` files are used for displaying intermediate steps in the terrain generation, while the `render.m`
contains the logic to render the end result of the terrain.


## Midpoint Displacement

Running the algorithm:
![](midpoint_displacement/midpoint_displacement_movie.gif?raw=true)

Copies of the heightmap with different Gaussian blurs applied:
![](midpoint_displacement/midpoint_displacement_smoothing_movie.gif?raw=true)

Combine the filtered images:
![](midpoint_displacement/smoothing_sum.png?raw=true)

Rendered terrain:
![](midpoint_displacement/midpoint_displacement_terrain.png?raw=true)


## Random Walk

Running the algorithm:
![](random_walk/random_walk_movie.gif?raw=true)

Copies of the heightmap with different Gaussian blurs applied:
![](random_walk/random_walk_smoothing_movie.gif?raw=true)

Combine the filtered images:
![](random_walk/smoothing_sum.png?raw=true)

Rendered terrain:
![](random_walk/random_walk_terrain.png?raw=true)


## Images

Using an actual heightmap to render terrain:
![](heightmap/terrain.jpg?raw=true)

![](heightmap/heightmap_terrain.png?raw=true)


An image of a cloud:
![](cloud/cloud.jpg?raw=true)

Copies of the heightmap with different Gaussian blurs applied:
![](cloud/cloud_smoothing_movie.gif?raw=true)

Combine the filtered images:
![](cloud/smoothing_sum.png?raw=true)

Rendered terrain:
![](cloud/cloud_terrain.png?raw=true)


An image of the center of the Milky Way:
![](galaxy/galaxy.jpg?raw=true)

Copies of the heightmap with different Gaussian blurs applied:
![](galaxy/galaxy_smoothing_movie.gif?raw=true)

Combine the filtered images:
![](galaxy/smoothing_sum.png?raw=true)

Rendered terrain:
![](galaxy/galaxy_terrain.png?raw=true)
