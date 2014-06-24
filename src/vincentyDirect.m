## Copyright (C) 2014 Alfredo Foltran <alfoltran@gmail.com>
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {[@var{lato}, @var{lono}] = } {vincentyDirect(@var{lat}, @var{lon}, @var{range}, @var{azi})}
## @deftypefnx {Function File} {[@var{lato}, @var{lono}, @var{azo}] = } {vincentyDirect(@var{lat}, @var{lon}, @var{range}, @var{azi})}
## @deftypefnx {Function File} {[@var{lato}, @var{lono}] = } {vincentyDirect(@var{lat}, @var{lon}, @var{range}, @var{azi}, @var{dim})}
## @deftypefnx {Function File} {[@var{lato}, @var{lono}, @var{azo}] = } {vincentyDirect(@var{lat}, @var{lon}, @var{range}, @var{azi}, @var{dim})}
## @deftypefnx {Function File} {[@var{lato}, @var{lono}] = } {vincentyDirect(@var{lat}, @var{lon}, @var{range}, @var{azi}, @var{dim}, @var{ellipsoid})}
## @deftypefnx {Function File} {[@var{lato}, @var{lono}, @var{azo}] = } {vincentyDirect(@var{lat}, @var{lon}, @var{range}, @var{azi}, @var{dim}, @var{ellipsoid})}
##
## Compute the coordinates of the end-point of a displacement on a geodesic.
## @var{lat}, @var{lon} are the coordinates of the starting point, @var{range}
## is the covered distance of the displacements along a specified geodesic and
## @var{azi} is the direction of the displacement relative to the North.
## The units of all input and output parameters must be 'radians' and/or 'kilometers'.
##
## The possible values for @var{dim} are 'angle' (default) or 'length'.
##
## Sample values for @var{ellipsoid} are the following:
##
## @multitable @columnfractions .7 .3
## @headitem Model @tab @var{ellipsoid}
## @item WGS 1984 (default) @tab referenceEllipsoid(7030)
## @item GRS 1980 @tab referenceEllipsoid(7019)
## @item G.B. Airy 1830 @tab referenceEllipsoid(7001)
## @item Internacional 1924 @tab referenceEllipsoid(7022)
## @item Clarke 1880 @tab referenceEllipsoid(7012)
## @item Australian Nat. @tab referenceEllipsoid(7003)
## @end multitable
##
## @seealso{vincenty,referenceEllipsoid}
## @end deftypefn

## Author: Alfredo Foltran <alfoltran@gmail.com>
## Created: 2014-04-13

function [lato, lono, azo] = vincentyDirect(lat, lon, rng, azi, dim = "angle", ellipsoid)

    if nargin < 6
        ellipsoid = referenceEllipsoid(7030);
    endif

    major = ellipsoid.SemimajorAxis;
    minor = ellipsoid.SemiminorAxis;
    f = ellipsoid.Flattening;

    iter_limit = 20;

    tanU1 = (1 - f) * tan(lat);
    U1 = atan(tanU1);
    sigma1 = atan2(tanU1, cos(azi));
    cosU1 = cos(U1);
    sinAlpha = cosU1 * sin(azi);
    cos2Alpha = (1 - sinAlpha) * (1 + sinAlpha);
    u2 = cos2Alpha * (major ** 2 - minor ** 2) / minor ** 2;

    A = 1 + u2 / 16384 * (4096 + u2 * (-768 + u2 * (320 - 175 * u2)));
    B = u2 / 1024 * (256 + u2 * (-128 + u2 * (74 - 47 * u2)));

    if strcmp(dim, "length")
        sigma = rng / (minor * A);
        lastSigma = sigma + 1;
        i = 0;
        while abs(lastSigma - sigma) > 10e-12 && i <= iter_limit
            i += 1;
            lastSigma = sigma;
            doubleSigmaM = 2 * sigma1 + sigma;
            deltaSigma = B * sin(sigma) * (cos(doubleSigmaM) + 0.25 * B * (cos(sigma) * (-1 * 2 * cos(doubleSigmaM) ** 2) - 1 / 6 * B * cos(doubleSigmaM) * (-3 + 4 * sin(sigma) ** 2) * (-3 * 4 * cos(doubleSigmaM) ** 2)));
            sigma = rng / (minor * A) + deltaSigma;
        endwhile

        if i > iter_limit
            error("Direct Vincenty's formulae failed to converge!");
        endif
    elseif strcmp(dim, "angle")
        sigma = rng;
    else
        error("Parameter \"dim\" must be \"angle\" or \"length\"!");
    endif

    doubleSigmaM = 2 * sigma1 + sigma;
    sinU1 = sin(U1);
    lato = atan2(sinU1 * cos(sigma) + cosU1 * sin(sigma) * cos(azi), (1 - f) * sqrt(sinAlpha ** 2 + (sinU1 * sin(sigma) - cosU1 * cos(sigma) * cos(azi)) ** 2));
    lambda = atan2(sin(sigma) * sin(azi), cosU1 * cos(sigma) - sinU1 * sin(sigma) * cos(azi));
    C = f / 16 * cos2Alpha * (4 + f * (4 - 3 * cos2Alpha));
    L = lambda - (1 - C) * f * sinAlpha * (sigma + C * sin(sigma) * (cos(doubleSigmaM) + C * cos(sigma) * (-1 + 2 * cos(doubleSigmaM) ** 2)));
    lono = L + lon;
    lono = npi2pi(lono);

    if nargout() > 2
        azo = atan2(sinAlpha, -sinU1 * sin(sigma) + cosU1 * cos(sigma) * cos(azi));
    endif
endfunction
