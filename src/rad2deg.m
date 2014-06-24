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
## @deftypefn {Function File} {} @var{anglout} = rad2deg(@var{anglin})
##
## Converts angles input in radians to the equivalent in degrees.
##
## @seealso{deg2rad}
## @end deftypefn

## Author: Andrew Collier <abcollier@users.sourceforge.net>
## Adapted-by: Alfredo Foltran <alfoltran@gmai.com>

function anglout = rad2deg(anglin)
    anglout = anglin * 180 / pi;
endfunction
