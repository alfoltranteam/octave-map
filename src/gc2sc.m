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
## @deftypefn {Function File} {[@var{lato}, @var{lono}, @var{range}] = } {gc2sc(@var{lat}, @var{lon}, @var{azi})}
## @deftypefnx {Function File} {[@var{lato}, @var{lono}] = } {gc2sc(@var{lat}, @var{lon}, @var{azi}, @var{units})}
## @deftypefnx {Function File} {} mat = gc2sc(@var{lat}, @var{lon}, @var{azi})
## @deftypefnx {Function File} {} mat = gc2sc(@var{lat}, @var{lon}, @var{azi}, @var{units})
##
## Converts a great circle to small circle notation.
##
## @end deftypefn

## Author: Alfredo Foltran <alfoltran@gmail.com>
## Created: 2014-04-13

function [lato, lono, rng] = gc2sc(varargin);

    units = "degrees";

    [reg, prop] = parseparams(varargin);

    ## Input checking
    if length(reg) != 3
        print_usage();
    endif

    sz = [1 1];

    for i=1:3
        if !isscalar(reg{i})
            sz = size(reg{i});
            break;
        endif
    endfor

    for i=1:3
        if isscalar(reg{i})
            reg{i} = repmat(reg{i}, sz);
        elseif !isequal(size(reg{i}), sz)
            print_usage();
        endif
    endfor

    if length(prop) == 1
        units = prop{1};
    elseif length(prop) > 1
        error("gc2sc: wrong number of type of arguments");
    end

    lat = reg{1};
    lon = reg{2};
    azi = reg{3};

    if strcmp(units, "degrees")
        d = pi / 180;
    elseif strcmp(units, "radians")
        d = 1;
    else
        error(["gc2sc: unknown units: " units]);
    endif

    ## convert from "units"

    lat = lat * d;
    lon = lon * d;
    azi = azi * d;

    ## implementation

    rng = pi / 2;
    [lato, lono] = reckon(lat, lon, rng, azi + pi / 2, "radians");

    ## convert to "units"

    lato = lato / d;
    lono = lono / d;
    rng = rng / d;

    if nargout() == 1
        lato = [lato lono rng];
    endif
endfunction
