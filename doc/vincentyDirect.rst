.. index:: Vincenty (Direct Form)

Vincenty (Direct Form)
==================================================

Compute the coordinates of the end-point of a displacement on a geodesic.
The parameters ``lat`` and ``lon`` are the coordinates of the starting point,
The parameter ``range`` is the covered distance of the displacements along a
specified geodesic and ``azi`` is the direction of the displacement relative
to the North.

Forms
--------------------------------------------------

.. function:: [lato, lono] = vincentyDirect(lat, lon, range, azi)
.. function:: [lato, lono, azo] = vincentyDirect(lat, lon, range, azi)
.. function:: [lato, lono] = vincentyDirect(lat, lon, range, azi, dim)
.. function:: [lato, lono, azo] = vincentyDirect(lat, lon, range, azi, dim)
.. function:: [lato, lono] = vincentyDirect(lat, lon, range, azi}, dim, ellipsoid)
.. function:: [lato, lono, azo] = vincentyDirect(lat, lon, range, azi, dim, ellipsoid)

.. note::

   The units of all input and output parameters must be 'radians' and/or 'kilometers'.
   ``dim`` defines the range dimension to use.
   ``ellipsoid`` defines the reference ellipsoid to use.


The possible values for ``dim`` are 'angle' (default) or 'length'.

Sample values for ``ellipsoid`` are the following:

* WGS_84 (default) - referenceEllipsoid(7030)
* GRS_80 - referenceEllipsoid(7019)
* Airy - referenceEllipsoid(7001)
* Intl - referenceEllipsoid(7022)
* Clarke - referenceEllipsoid(7012)
* GRS - referenceEllipsoid(7003)

The sample values are the following:

=================== =========== ============== ==============
Model               Major (km)  Minor (km)     1 / f
=================== =========== ============== ==============
WGS 1984            6378.137    6356.7523142   298.257223563
GRS 1980            6378.137    6356.7523141   298.257222101
G.B. Airy 1830      6377.563396 6356.256909    299.3249646
Internacional 1924  6378.388    6356.911946    297.0
Clarke 1880         6378.249145 6356.51486955  293.465
Australian Nat.     6378.1600   6356.774719    298.25
=================== =========== ============== ==============

Examples
--------------------------------------------------

Usages::

   >> [lat, lon] = vincentyDirect(0, 0, pi, pi / 2)
   lat = 0
   lon = 3.1311
   >> [lat, lon, az] = vincentyDirect(0, 0, pi, pi / 2)
   lat = 0
   lon = 3.1311
   az = 1.5708


.. seealso::

   :doc:`vincenty`
   :doc:`referenceEllipsoid`
