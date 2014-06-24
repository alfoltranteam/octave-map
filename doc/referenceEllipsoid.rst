.. index:: Reference Ellipsoid

Reference Ellipsoid
==================================================

This function returns a reference ellipsoid object corresponding to the
specified ``code`` (numerical EPSG). The values of the ``SemimajorAxis``
and ``SemiminorAxis`` properties are in kilometers. The reference
ellipsoid has five properties: ``Code``, ``Name``, ``SemimajorAxis``, ``SemiminorAxis``
and ``Flattening``.

The form code can receive a valid EPSG code. 46 codes are currently
implemented between 7001 and 7053 (except for 7017, 7023, 7026 and
7037-7040).

The valid values for name form are as follows: sphere, unitsphere, earth,
moon, mercury, venus, mars, jupiter, saturn, uranus, neptune and pluto.

Forms
--------------------------------------------------

.. function:: ref = referenceEllipsoid(code)
.. function:: ref = referenceEllipsoid(name)
