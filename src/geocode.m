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
## along with this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {[@var{lato}, @var{lono}] = } {geocode(@var{addr})}
## @deftypefnx {Function File} {[@var{lato}, @var{lono}, @var{xml}] = } {geocode(@var{addr})}
##
## Geolocation service from Google Maps API. Define a geocode method for resolving a location from a string.
## Geocoding is the process of converting addresses (like "1600 Amphitheatre Parkway, Mountain View, CA") into
## geographic coordinates (like latitude 37.423021 and longitude -122.083739), which you can use to place
## markers or position the map. Reverse geocoding is the process of converting geographic coordinates into a
## human-readable address.
##
## Usage:
## @example
## >> [lat, lon] = geocode('new york,ny')
## lat = 40.714
## lon = -74.006
## >> [lat, lon] = geocode('brasilia,df')
## lat = -15.827
## lon = -47.922
## @end example
##
## @seealso{reverse}
## @end deftypefn

## Author: Alfredo Foltran <alfoltran@gmail.com>

function [lato, lono, xml] = geocode(addr)
    url = 'http://maps.googleapis.com/maps/api/geocode/';
    resultType = 'xml';
    [xml, success, msg] = urlread([url resultType], 'get', {'address', addr, 'sensor', 'false'});

    if success
        sta = strfind(xml, '<location>');
        fin = strfind(xml, '</location>');
        if isempty(sta)
            lato = 'none';
            lono = 'none';
        else
            loc = substr(xml, sta(1) + 10, fin(1) - sta(1) - 10);

            sta = strfind(loc, '<lat>');
            fin = strfind(loc, '</lat>');
            lato = str2num(substr(loc, sta + 5, fin - sta - 5));

            sta = strfind(loc, '<lng>');
            fin = strfind(loc, '</lng>');
            lono = str2num(substr(loc, sta + 5, fin - sta - 5));
        endif
    else
        error(msg);
    endif
endfunction
