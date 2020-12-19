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

2. How to add additional applications to my image
-------------------------------------------------

If you want to add new applications to your image you can set the following
variable in your `local.conf`:

.. code::

	IMAGE_INSTALL_append = " \
		gdb                  \
		htop                 \
	"

The example above will add `gdb` and `htop` to the image that gets built by
`bitbake`.

3. Connecting to the board by ssh over USB does not work on Windows
-------------------------------------------------------------------

By default the BSP uses the USB gadget `ecm` to provide a network interface
over USB. Windows does not support well `ecm`. so if you plan to connect
to the board  by ssh over USB on Windows, it is recommended to build an image
that will use the USB gadget `rndis` instead of `ecm`.

To use the `rndis` USB gadget instead of `ecm`, please add the following in
your `local.conf`:

.. code::

	USB_GADGET_FUNCTION = "rndis"
