.. index:: Distance

Distance
==================================================

Calculates the distance (in degrees) between **point 1** and **point 2**.

Forms
--------------------------------------------------

.. function:: dist = distance(pt1, pt2)

.. note::

   ``pt1`` and ``pt2`` are two-column matrices of the form ``[latitude longitude]``.


Examples
--------------------------------------------------

Usages::

   >> distance([37,-76], [37,-9]) 
   ans = 52.309
   >> distance([37,-76], [67,-76])
   ans = 30.000


.. seealso::

   :doc:`azimuth`
   :doc:`vincenty`
