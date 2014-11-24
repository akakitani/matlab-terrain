function render(heightmap, detail_level, height_scale)
    detail = 1 / detail_level;
    [size_x, size_y] = size(heightmap);

    [X,Y] = meshgrid(1:size_x, 1:size_y);
    [Xq, Yq] = meshgrid(1:detail:size_x, 1:detail:size_y);

    Z = interp2(X, Y, heightmap, Xq, Yq);
    f = filter2(fspecial('gaussian'), Z);
    Z = conv2(Z, f, 'same');

    % Scale to between 0 and 1
    Z = (Z - min(Z(:))) ./ (max(Z(:) - min(Z(:))));
    % Then to between -SIZE and +SIZE
    %Z = ((Z * 2) - 1) * (height_scale);

    pcolor(Xq, Yq, Z);
    surf(Xq, Yq, Z);

    axis vis3d;
    set(gca, 'Projection', 'perspective');

    colormap(getfield(load('cape', 'map'), 'map'));
    shading interp;                  % Interpolate color across faces.
    material dull;
    camlight left;                   % Add a light over to the left somewhere.
    lighting gouraud;                % Use decent lighting.
    drawnow;

    fprintf('Terrain rendering finished.\n\n');

end