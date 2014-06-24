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
## @deftypefn {Function File} {@var{addr} = } {reverse([@var{lat} @var{lon}])}
## @deftypefnx {Function File} {[@var{addr}, @var{xml}] = } {reverse([@var{lat} @var{lon}])}
##
## Geolocation service from Google Maps API. Define a geocode method for resolving a address
## from a location. The term geocoding generally refers to translating a human-readable address
## into a location on a map. The process of doing the converse, translating a location on the map
## into a human-readable address, is known as reverse geocoding.
##
## Usage:
## @example
## >> reverse([40.714 -74.006])
## ans = '58-68 Chambers Street, Nova York, NY 10007, EUA'
## >> reverse([-15.827 -47.922])
## ans = 'Asa Sul, Brasília, DF, 70383-070, Brasil'
## @end example
##
## @seealso{geocode}
## @end deftypefn

## Author: Alfredo Foltran <alfoltran@gmail.com>

function [addr, xml] = reverse(location)
    url = 'http://maps.googleapis.com/maps/api/geocode/';
    resultType = 'xml';
    [xml, success, msg] = urlread([url resultType], 'get', {'latlng', [num2str(location(1)) ',' num2str(location(2))], 'sensor', 'false'});

    if success
        sta = strfind(xml, '<formatted_address>');
        fin = strfind(xml, '</formatted_address>');
        if isempty(sta)
            addr = 'none';
        else
            addr = substr(xml, sta(1) + 19, fin(1) - sta(1) - 19);
        endif
    else
        error(msg);
    endif
endfunction
