.. index:: Departure

Departure
==================================================

Calculates the distance in **degrees** between longitudes ``lon1`` and ``lon2`` at
latitude defined by ``lat``.

Forms
--------------------------------------------------

.. function:: dist = departure(lon1, lon2, lat)


Examples
--------------------------------------------------

Usages::

   >> departure(0, 10, 0)
   ans = 10
   >> departure(0, 10, 60)
   ans = 5


.. seealso::

   :doc:`distance`
