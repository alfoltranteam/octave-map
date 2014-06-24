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
## @deftypefn {Function File} {} @var{angout} = npi2pi(@var{angin})
##
## This brings the @var{angin} into the [-pi pi] interval.
##
## @end deftypefn

## Author: Alfredo Foltran <alfoltran@gmail.com>
## Created: 2014-04-15

function angout = npi2pi(angin)
    angout = mod(angin + pi, 2 * pi);

    if angout == 0 || angout == pi
        angout = sign(angin) * pi;
    else
        angout -= pi;
    endif
endfunction
