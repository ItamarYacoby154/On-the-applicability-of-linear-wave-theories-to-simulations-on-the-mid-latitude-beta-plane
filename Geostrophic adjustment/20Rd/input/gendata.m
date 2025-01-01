ieee = 'b';           % big-endian format
accuracy = 'float32'; % this is single-precision (='real*4')

Ho = 500;  % ocean depth in meters
nx = 4;    % number of gridpoints in x-direction
ny = 12000;    % number of gridpoints in y-direction
xo = -0.1;     % origin in x,y for ocean domain
yo = -0.05;     % (i.e. southwestern corner of ocean domain)
dx = 0.05;    % grid spacing in x (km)
dy = 0.05;    % grid spacing in y (km)
xeast  = xo + (nx-2)*dx;  % eastern extent of ocean domain
ynorth = yo + (ny-2)*dy;  % northern extent of ocean domain

% Flat bottom at z=-Ho
h = -Ho * ones(nx, ny);

% Walls (surrounding domain); generate bathymetry file
% h([1 end], :) = 0;   % set ocean depth to zero at east and west walls
h(:, [1 end]) = 0;   % set ocean depth to zero at south and north walls
fid = fopen('bathy.bin', 'w', ieee);
fwrite(fid, h, accuracy);
fclose(fid);

eta0 = zeros(nx, ny);
eta0(:,1:6000) = 1;
eta0(:,6001:12000) = -1;

fid = fopen('eta0.bin', 'w', ieee);
fwrite(fid, eta0, accuracy);
fclose(fid);
