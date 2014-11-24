    clear
    clf

    SIZE = (2 ^ 5) + 1;
    MAX_HEIGHT = SIZE;
    DETAIL = 0.05;
    heightmap = midpoint_displacement(SIZE, MAX_HEIGHT);

    [X,Y] = meshgrid(1:SIZE, 1:SIZE);
    [Xq, Yq] = meshgrid(1:DETAIL:SIZE, 1:DETAIL:SIZE);

    smoothed = interp2(X, Y, heightmap, Xq, Yq);
    pcolor(Xq, Yq, smoothed);
    mesh(smoothed);

    xlabel('x');
    ylabel('y');
    view([+34.5 14]);

    drawnow;

    fprintf('Simulation finished.\n\n');
