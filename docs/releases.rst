RITY releases
=============

The RITY SDK supports the following Yocto release:

	* Yocto 3.1, codename: Dunfell (LTS)
	* Yocto 3.2, codename: Gatesgarth (Stable)

RITY is getting a new release about every 3 months, the latest one is
|release|.

Download the RITY SDK
---------------------

The RITY SDK can be downloaded using `repo` as follows:

.. parsed-literal::

    $ mkdir rity; cd rity
    $ repo init -u git@gitlab.com:baylibre/rich-iot/manifest.git -b |release|
    $ repo sync

You can replace '|release|' with any of the :ref:`releases:releases tags`
or :ref:`releases:development branches`.

Development branches
--------------------

If you wish to use bleeding edge code you can use the RITY development branches,
It is not recommended to use development branches unless you need
a feature that is not yet in any releases or wish to participate in the
development of the RITY SDK.

+-----------------+---------------+
| Branch name     | Status        |
+=================+===============+
| rity/gatesgarth | Active        |
+-----------------+---------------+
| rity/dunfell    | Backport only |
+-----------------+---------------+

Only one development branch is active at a time. The other branches will
receive occasional backport from the active branch.

Releases tags
----------------

List of all the RITY releases:

+------------+---------------+-----------+
| Tag        | Yocto Release | Status    |
+============+===============+===========+
| rity-v21.0 | dunfell       | Supported |
+------------+---------------+-----------+
| rity-v20.2 | dunfell       | Obsolete  |
+------------+---------------+-----------+
| rity-v20.1 | dunfell       | Obsolete  |
+------------+---------------+-----------+
| rity-v20.0 | zeus          | Obsolete  |
+------------+---------------+-----------+
| rity-3.0   | thud          | Obsolete  |
+------------+---------------+-----------+
| rity-2.0   | thud          | Obsolete  |
+------------+---------------+-----------+
| rity-1.0   | thud          | Obsolete  |
+------------+---------------+-----------+
