.. index:: Reverse

Reverse
==================================================

Geolocation service from Google Maps API. Define a geocode method for resolving a address
from a location.

The term geocoding generally refers to translating a human-readable address
into a location on a map. The process of doing the converse, translating a location on the map
into a human-readable address, is known as reverse geocoding.

Forms
--------------------------------------------------

.. function:: addr = reverse([lat lon])
.. function:: [addr, xml] = reverse([lat lon])


Examples
--------------------------------------------------

Usages::

    >> reverse([40.714 -74.006])
    ans = '58-68 Chambers Street, Nova York, NY 10007, EUA'
    >> reverse([-15.827 -47.922])
    ans = 'Asa Sul, Brasília, DF, 70383-070, Brasil'

.. seealso::

   :doc:`geocode`
