function generate_terrain(size, detail, gen_function)
    SIZE = (2 ^ size) + 1;
    MAX_HEIGHT = SIZE;
    DETAIL = detail;
    heightmap = gen_function(SIZE, MAX_HEIGHT);

    [X,Y] = meshgrid(1:SIZE, 1:SIZE);
    [Xq, Yq] = meshgrid(1:DETAIL:SIZE, 1:DETAIL:SIZE);

    interpolated_heightmap = interp2(X, Y, heightmap, Xq, Yq);
    pcolor(Xq, Yq, interpolated_heightmap);

    y = filter2(fspecial('gaussian'), interpolated_heightmap);
    mesh(Xq, Yq, conv2(interpolated_heightmap, y, 'same'));
    xlabel('x');
    ylabel('y');
    view([+34.5 14]);
    drawnow;

    fprintf('Simulation finished.\n\n');
end
