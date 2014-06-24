.. index:: Geocode

Geocode
==================================================

Geolocation service from Google Maps API. Define a geocode method for resolving a location from a string.

Geocoding is the process of converting addresses (like "1600 Amphitheatre Parkway, Mountain View, CA") into
geographic coordinates (like latitude 37.423021 and longitude -122.083739), which you can use to place
markers or position the map.

Reverse geocoding is the process of converting geographic coordinates into a human-readable address.

Forms
--------------------------------------------------

.. function:: [lato, lono] = geocode(addr)
.. function:: [lato, lono, xml] = geocode(addr)


Examples
--------------------------------------------------

Usages::

   >> [lat, lon] = geocode('new york,ny')
   lat = 40.714
   lon = -74.006
   >> [lat, lon] = geocode('brasilia,df')
   lat = -15.827
   lon = -47.922

.. seealso::

   :doc:`reverse`
