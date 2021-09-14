RITY Demo Image
===============

The `RITY Demo Image` is used to demonstrate the RITY BSP. The image contains
a set of tools, applications, configurations that are targetted at showing
the RITY BSP for evaluation. The demo image also demonstrate how to build
a custom image on top of the RITY BSP.

DISTRO
------

`RITY Demo Image` is designed to be build with the `DISTRO` variable set
to the following:

.. code::

	DISTRO=rity-demo

Building
--------

To build the `RITY Demo Image` you can run the following command:

.. prompt:: bash $

	DISTRO=rity-demo MACHINE=<machine> bitbake rity-demo-image

Connect to the Internet
-----------------------

The RITY Demo Image is using
`Network-Manager <https://en.wikipedia.org/wiki/NetworkManager>`_ to manage
and configure network interfaces.

Wi-Fi
^^^^^

You can connect to your Wi-Fi access point `<my_wifi_ssid>` using the following
command:

.. code::

	$ nmcli d wifi connect <my_wifi_ssid> password <my_wifi_password>

.. note::

	Some boards do not include any antennas by default, please
	refer to the board documentation for more information.

Package Management
------------------

The `RITY Demo Image` has the debian package management enabled. By default
`apt` will look for packages over the USB device connection.

Configuration
^^^^^^^^^^^^^

.. code::

	PACKAGE_CLASSES ?= "package_deb"
	PACKAGE_FEED_URIS ?= "http://192.168.96.20:9876"
	EXTRA_IMAGE_FEATURES:append = " package-management "

The above variable can be modified in your `local.conf` if you need a different
configuration.

Building new packages
^^^^^^^^^^^^^^^^^^^^^

If you need to add a new package to the `APT` repository, you need to first
build it in yocto:

.. prompt:: bash $

	bitbake vim

Once the package is built, you need to update the `APT` index:

.. prompt:: bash $

	bitbake package-index

Run the HTTP server
^^^^^^^^^^^^^^^^^^^

The APT packages are availlable through a HTTP server. You can start the HTTP
server using the following commands:

.. prompt:: bash $

	cd build/tmp/deploy/deb/
	python3 -m http.server 9876

Installing a package on the board
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Every time you update the APT index, you must run `apt-get update` on the
board in order for the board to get an up-to-date view of the package index.

.. prompt:: bash $

	apt-get update

Then you can install the package you just built using the following command:

.. prompt:: bash $

	apt-get install vim
