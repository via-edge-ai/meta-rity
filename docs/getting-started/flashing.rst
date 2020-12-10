Flashing
========

Prerequisites
-------------

In order to flash your images, your host machine must be able talk to the
board SoC. You need to make sure that the user session on your host machine
has the right permission to talk to the SoC via USB.

udev rule
^^^^^^^^^

`udev <https://en.wikipedia.org/wiki/Udev>`_ is a device manager for
the Linux kernel. It can be used to grant permission to a device to
an user or a group.

Please run the following command in order to create a udev rule that will
grant access to the USB device that allows the host to talk to the SoC.

.. code::

	$ echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", ATTR{idProduct}=="201c", MODE="0660", GROUP="plugdev"' | sudo tee -a /etc/udev/rules.d/96-rity.rules
	$ sudo udevadm control --reload-rules
	$ sudo udevadm trigger

Adding your user to the `plugdev` group
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The udev rule grant the permission to the `plugdev` group to the SoC USB device.
In order for your user to be able to talk to the SoC, your user must be part
of the `plugdev` group. Run the following command to add yourself to the
`plugdev` group.

.. code::

	$ sudo usermod -a -G plugdev $USER

This last command requires you to log out and log back in to your account to be
in effect.

Flashing an image
-----------------

To flash a entire image, please run the command below. <machine> should
be replace to contain the value of the `MACHINE` variable that was used to
build the SDK.

.. code::

	$ cd rity/build/tmp/deploy/images/<machine>
	$ ./flashimage.py -i rity-demo-image
	                    Checking image
	----------------------------------------------------------------------------
	                      MBR_EMMC : PASS
	                       bl2.img : PASS
	                u-boot-env.bin : PASS
	                       fip.bin : PASS
	                      fitImage : PASS
	rity-demo-image-<machine>.ext4 : PASS

	                     Start flashing
	---------------------------------------------------------------------------
	Waiting for DA mode
	.

Once you see `Waiting for DA mode`:

	1. press and keep pressing the `volume up` button
	2. press and release the `reset` button
	3. release the `volume up` button

You should see the board getting flash immediately after releasing the
`volume up` button.
