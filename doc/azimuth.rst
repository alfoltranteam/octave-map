.. index:: Azimuth

Azimuth
==================================================

Calculates the great circle azimuth from a **point 1** to a **point 2**.
The latitude and longitude of these two points can either be given independently
or as columns of the matrices **point 1** and **point 2** in the form ``[latitude longitude]``.

Forms
--------------------------------------------------

.. function:: az = azimuth(lat1, lon1, lat2, lon2)
.. function:: az = azimuth(lat1, lon1, lat2, lon2, units)
.. function:: az = azimuth(pt1, pt2)
.. function:: az = azimuth(pt1, pt2, units)

.. note::

   The units for the input coordinates and output angles can be *degrees* (the default) or *radians*.


Examples
--------------------------------------------------

Usages::

   >> azimuth([10, 10], [10, 40])
   ans = 87.336
   >> azimuth([0, 10], [0, 40])
   ans = 90
   >> azimuth(pi / 4, 0, pi / 4, -pi / 2, "radians")
   ans = 5.3279


.. seealso::

   :doc:`reckon`
   :doc:`distance`
