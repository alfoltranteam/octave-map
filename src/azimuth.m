## Copyright (C) 2004 Andrew Collier <abcollier@users.sourceforge.net>
##
## This program is free software; it is distributed in the hope that it
## will be useful, but WITHOUT ANY WARRANTY; without even the implied
## warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
## the GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this file; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {} @var{az} = azimuth(@var{lat1}, @var{lon1}, @var{lat2}, @var{lon2})
## @deftypefnx {Function File} {} @var{az} = azimuth(@var{lat1}, @var{lon1}, @var{lat2}, @var{lon2}, @var{ellipsoid})
## @deftypefnx {Function File} {} @var{az} = azimuth(@var{lat1}, @var{lon1}, @var{lat2}, @var{lon2}, @var{units})
## @deftypefnx {Function File} {} @var{az} = azimuth(@var{lat1}, @var{lon1}, @var{lat2}, @var{lon2}, @var{ellipsoid}, @var{units})
## @deftypefnx {Function File} {} @var{az} = azimuth(@var{pt1}, @var{pt2})
## @deftypefnx {Function File} {} @var{az} = azimuth(@var{pt1}, @var{pt2}, @var{ellipsoid})
## @deftypefnx {Function File} {} @var{az} = azimuth(@var{pt1}, @var{pt2}, @var{units})
## @deftypefnx {Function File} {} @var{az} = azimuth(@var{pt1}, @var{pt2}, @var{ellipsoid}, @var{units})
##
## Calculates the great circle azimuth from a point 1 to a point 2.
## The latitude and longitude of these two points can either be given 
## independently or as columns of the matrices @var{pt1} and @var{pt2} in 
## the form [latitude longitude].
##
## The units for the input coordinates and output angles can be 
## "degrees" (the default) or "radians".
##
## @example
## >> azimuth([10, 10], [10, 40])
## ans = 87.336
## >> azimuth([0, 10], [0, 40])
## ans = 90
## >> azimuth(pi / 4, 0, pi / 4, -pi / 2, "radians")
## ans = 5.3279
## @end example
##
## @seealso{reckon,distance,referenceEllipsoid}
## @end deftypefn

## Author: Andrew Collier <abcollier@users.sourceforge.net>
## Adapted-by: Alexander Barth <abarth93@users.sourceforge.net>
## Adapted-by: Alfredo Foltran <alfoltran@gmai.com>

function az = azimuth(varargin)
    ## default units are degrees

    units = "degrees";

    [reg,prop] = parseparams(varargin);

    sphere = true;
    if length(reg) == 3 || length(reg) == 5
        ellipsoid = reg{length(reg)};
        if ellipsoid.Flattening ~= 0
            sphere = false;
        end
    end

    if length(prop) == 1
        units = prop{1};

        if (~strcmp(units, "degrees") && ~strcmp(units, "radians"))
            error("Only degrees and radians are allowed as units");
        end
    elseif length(prop) > 1
        error("Wrong number of type of arguments");
    end

    if sphere
        if length(reg) == 2 || length(reg) == 3
            pt1 = reg{1};
            pt2 = reg{2};

            a = pt1(:,1);
            b = pt2(:,1);
            C = pt2(:,2) - pt1(:,2);
        elseif length(reg) == 4 || length(reg) == 5
            a = reg{1};
            b = reg{3};
            C = reg{4} - reg{2};
        else
            error("Wrong number of type of arguments");
        end

        if (strcmp(units, "degrees"))
            a = deg2rad(a);
            b = deg2rad(b);
            C = deg2rad(C);
        end

        az = atan2(sin(C) , cos(a) .* tan(b) - sin(a) .* cos(C));

        ## bring the angle in the interval [0 2*pi[

        az = zero22pi(az);
    else
        if length(reg) == 2 || length(reg) == 3
            pt1 = reg{1};
            pt2 = reg{2};
        elseif length(reg) == 4 || length(reg) == 5
            pt1 = [reg{1} reg{2}];
            pt2 = [reg{3} reg{4}];
        else
            error("Wrong number of type of arguments");
        end

        if (strcmp(units, "degrees"))
            [dist az] = vincenty(pt1, pt2, ellipsoid);
        else
            [dist az] = vincenty(rad2deg(pt1), rad2deg(pt2), ellipsoid);
        end

        az = zero22pi(deg2rad(az(1)));
    end

    ## convert to degrees if desired

    if (strcmp(units, "degrees"))
        az = rad2deg(az);
    end
endfunction
