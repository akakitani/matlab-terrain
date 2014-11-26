function Z = dla(grid_max, max_height)
    % Initialize corners
    Z = zeros(grid_max, grid_max);
    Z = divide(Z, grid_max, max_height);
end


% DIFFUSION LIMITED AGGREGATION along a sticky wall using Brownian motion
%
% Read "The Science of Fractal Images", Ed. Peitgen and Saupe, p. 37 (1988)

% Author : B. Militzer, University of California, Berkeley
% Date   : Sep 21, 2009

nParticles = 50000;
maxX = 1000;
maxY = 500;

nNewParticlesPerFrame = 100;

% Initialize matrix containing all 2D gird points A(x,y)
% 1 <= x <= maxX
% 1 <= y <= maxY
% A(x,y)=0 ... cite is empty
% A(x,y)>0 ... cite is filled
A = zeros(maxX, maxY);

% Introduce a solid wall of already aggreated particles at y=1
A(:,1) = 1;

% To save computer time, we want to inject the new particle not too far
% above growing aggreate. We inject at on a line 'yStart', which
% keeps being increased so that it is always 'yBuffer' lines above the
% highest frozen particle
yBuffer = 5;
yStart = 1+yBuffer;

DIRECTION_LEFT = 0;
DIRECTION_UP = 1;
DIRECTION_RIGHT = 2;
DIRECTION_DOWN = 3;

PROB_LEFT = 0.1;
PROB_RIGHT = 0.5;
PROB_UP = 0.75;
PROB_DOWN = 1.0;

PROB_STICK_THRESH = 0.5;

for i = 1:nParticles
    % Compute new starting point on line y=yStart
    x  = 1+floor(maxX*rand);
    y  = yStart; %always start at upper limit

    while 1
        xOld = x; %store current x and y values
        yOld = y;

        % Arbitrarily select direction to turn to
        r = rand();

        %%% Determine the direction of motion using the random number 'r'
        %%% Update 'x' and 'y' with the following probabilities
        %%% 25% go LEFT
        %%% 25% go RIGHT
        %%% 25% go UP
        %%% 25% go DOWN
        %%% --> need to enter about 10 lines of code
        if (r < PROB_LEFT)
            x = x - 1;
        elseif (r >= PROB_LEFT && r < PROB_RIGHT)
            x = x + 1;
        elseif (r >= PROB_RIGHT && r < PROB_UP)
             y = y + 1;
        elseif (r >= PROB_UP && r < PROB_DOWN)
            y = y - 1;
        end


        %%% Now apply periodic boundary conditions in X direction
        %%% x must stay with 1 <= x <= maxX
        %%% if x exits to the left, let it enter on the right
        %%% if x exits to the right, let it enter on the left
        %%% --> enter 6 lines of code (or less)

        x = mod(x, maxX);
        if (x == 0)
            x = maxX;
        end

        if (y>yStart)   % did the particle diffuse through the ceiling?
            y = yStart; % just set back to max if is gets too high
        end

        if (A(x,y)>0) % ok, this site has been taken already, reject the move
            x=xOld;
            y=yOld;
            continue;
        end

        xR = x+1; % xRIGHT = x coordinate of my right neighbor
        xL = x-1; % xLEFT  = x coordinate of my left  neighbor
        yU = y+1; % yUP    = y coordinate of my upper neighor
        yD = y-1; % yDOWN  = y coordinate of my lower neighbo

        %%% Now apply periodic boundary conditions to xL and xR

        xR = mod(xR, maxX);
        if (xR == 0)
            xR = maxX;
        end

        xL = mod(xL, maxX);
        if (xL == 0)
            xL = maxX;
        end

        stick_prob = rand();

        if (stick_prob < PROB_STICK_THRESH)
            % Any of my 4 neighor filled already? If yes, get stuck here
            if (A(xR,y) > 0 || A(xL,y) > 0 || A(x,yU) > 0 || A(x,yD) > 0)
                A(x,y) = 1; % mark site as taken
                if (y+yBuffer>yStart && y+yBuffer<maxY)
                    yStart = y+yBuffer;
                end
                fprintf('i= %5d x=%4d y=%4d yStart=%4d\n',i,x,y,yStart);
                break;
            end
        end

    end

    if (i==nParticles || mod(i,nNewParticlesPerFrame)==0 || yStart+1==maxY)
        imagesc(A');
        set(gca,'YDir','normal');
        colormap(1-gray);
        axis equal;
        axis tight;
        drawnow
    end

    if (yStart+1==maxY)
        fprintf('Growth reached Y limit after only %d particles\n',i);
        break;
    end
end


