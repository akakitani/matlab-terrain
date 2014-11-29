# Matlab Terrain Generation

Final project for Earth and Planetary Science 109

To run, just use `main.m`. The midpoint displacement algorithm is currently the only one that's not commented out, but
all the other terrain generation methods can also be run just by uncommenting them.


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
