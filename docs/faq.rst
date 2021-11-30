Frequently Asked Questions
==========================

1. My rootfs is too small, how to make it larger?
-------------------------------------------------

The BSP does not specify any storage size, so the rootfs will be just large
enough to contain the content built by the yocto image. If you need to
increase the size the size of the rootfs you can add the following to your
`local.conf`:

.. code::

	IMAGE_ROOTFS_EXTRA_SPACE = "500000" # KBytes

`IMAGE_ROOTFS_EXTRA_SPACE`_ can be set to increase
the amount of free disk space in the rootfs partition.

For more information you can check the `Yocto Reference Manual`_.

.. _IMAGE_ROOTFS_EXTRA_SPACE: https://www.yoctoproject.org/docs/latest/ref-manual/ref-manual.html#var-IMAGE_ROOTFS_EXTRA_SPACE
.. _Yocto Reference Manual: https://www.yoctoproject.org/docs/latest/ref-manual/ref-manual.html#idm46031661356992

2. My home partition is too small, how to make it larger?
---------------------------------------------------------

You can set the home partition size by setting the following variable in
your `local.conf`:

.. code::

	IMAGE_HOME_SIZE = "500M"

3. How to add additional applications to my image
-------------------------------------------------

If you want to add new applications to your image you can set the following
variable in your `local.conf`:

.. code::

	IMAGE_INSTALL:append = " \
		gdb                  \
		htop                 \
	"

The example above will add `gdb` and `htop` to the image that gets built by
`bitbake`.

4. Connecting to the board by ssh over USB does not work on Windows
-------------------------------------------------------------------

By default the BSP uses the USB gadget `adb+rndis` to provide both debug and
network interface over USB. Install Google's USB driver for `adb` interface,
and Windows built-in `rndis` driver.

For more information you can check the `Get the Google USB Driver`_.

.. _Get the Google USB Driver: https://developer.android.com/studio/run/win-usb
