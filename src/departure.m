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
## @deftypefn {Function File} {} @var{dist} = departure(@var{lon1}, @var{lon2}, @var{lat})
## @deftypefnx {Function File} {} @var{dist} = departure(@var{lon1}, @var{lon2}, @var{lat}, @var{units})
## @deftypefnx {Function File} {} @var{dist} = departure(@var{lon1}, @var{lon2}, @var{lat}, @var{ellipsoid})
## @deftypefnx {Function File} {} @var{dist} = departure(@var{lon1}, @var{lon2}, @var{lat}, @var{ellipsoid}, @var{units})
##
## Calculates the distance (in degrees) between longitudes @var{lon1} and @var{lon2} at
## latitude defined by @var{lat}.
##
## The units for the input coordinates and output angles can be 
## "degrees" (the default) or "radians".
##
## @example
## >> departure(0, 10, 0)
## ans = 10
## >> departure(0, 10, 60)
## ans = 5
## @end example
##
## @seealso{distance,referenceEllipsoid}
## @end deftypefn

## Author: Alfredo Foltran <alfoltran@gmail.com>
## Created: 2014-04-13

function dist = departure(varargin)
    ## default units are degrees

    units = "degrees";

    [reg,prop] = parseparams(varargin);

    ellipsoid = 0;
    if length(reg) == 4
        ellipsoid = reg{4};
    elseif length(reg) ~= 3
        error("Wrong number of type of arguments");
    end

    lon1 = reg{1};
    lon2 = reg{2};
    lat = reg{3};

    if length(prop) == 1
        units = prop{1};

        if (~strcmp(units, "degrees") && ~strcmp(units, "radians"))
            error("Only degrees and radians are allowed as units");
        end
    elseif length(prop) > 1
        error("Wrong number of type of arguments");
    end

    if isstruct(ellipsoid)
        if (strcmp(units, "degrees"))
            dist = vincenty([lat lon1], [lat lon2], ellipsoid);
        else
            dist = vincenty(rad2deg([lat lon1]), rad2deg([lat lon2]), ellipsoid);
        end
    else
        if (strcmp(units, "degrees"))
            dist = cosd(lat) * (lon2 - lon1);
        else
            dist = cos(lat) * (lon2 - lon1);
        end
    end
endfunction
