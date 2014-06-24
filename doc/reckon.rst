.. index:: Reckon

Reckon
==================================================

Compute the coordinates of the end-point of a displacement on a sphere.
**lat** e **lon** are the coordinates of the starting point, **range** is the
covered distance of the displacements along a great circle and **azimuth** is the
direction of the displacement relative to the North.

This function can also be used to define a spherical coordinate system with rotated poles.

Forms
--------------------------------------------------

.. function:: [lato, lono] = reckon(lat, lon, range, azimuth)
.. function:: [lato, lono] = reckon(lat, lon, range, azimuth, units)

.. note::

   The units of all input and output parameters can be either *degrees* (default) or *radians*.


Examples
--------------------------------------------------

Usages::

   >> [lato, lono] = reckon(0, 10, 30, 90)
   lato = 0
   lono =  40.000
   >> [lato, lono] = reckon(0, 0, pi, pi / 2, "radians")
   lato = 0
   lono = -3.1416


.. seealso::

   :doc:`azimuth`
