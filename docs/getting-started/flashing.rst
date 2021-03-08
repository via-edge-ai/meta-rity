Flashing (Linux)
================

RITY tools
----------

RITY tools is a set of tools to configure or interact with MediaTek boards.

.. note::

	This page is only a short introduction to using the RITY tools,
	it is strongly advised to `fully read the RITY tools manual <https://baylibre.gitlab.io/rich-iot/tools/rity-tools>`_
	in order to get the most out of the RITY tools.

RITY tools installation
-----------------------

RITY flashing process requires you to install
the `RITY tools <https://baylibre.gitlab.io/rich-iot/tools/rity-tools/>`_.

Prerequisites
-------------

In order to flash your images, your host machine must be able talk to the
board SoC. You need to make sure that the user session on your host machine
has the right permission to talk to the SoC via USB.

You can check if your host machine is correctly configured to talk to the SoC by
running `rity-config <https://baylibre.gitlab.io/rich-iot/tools/rity-tools/#rity-config>`_.
In the case that your host machine is not correctly configured, `rity-config`
will give you instructions on how to correctly configure your host machine.

Enter download mode
-------------------

In order to be able to flash, you often need to set the SoC in `download mode`,
which will allow the RITY tools to download on the SoC's SRAM a binary that
will provide a `fastboot` interface.

To enter download mode you need to press the board buttons as follows:

	1. press and keep pressing the `volume up` button
	2. press and release the `reset` button
	3. release the `volume up` button

.. note::

	`volume up` is sometimes called KPCOL0

Flashing an image
-----------------

To flash a entire image, please run the command below. <machine> should
be replace to contain the value of the `MACHINE` variable that was used to
build the SDK.

.. prompt:: bash $ auto

	$cd rity/build/tmp/deploy/images/<machine>
	$rity-flash -i rity-demo-image
	Yocto Image:
	        name:     Rity Demo Image (rity-demo-image)
	        distro:   Rity demo 21.1-dev (rity-demo)
	        codename: gatesgarth
	        machine:  i300a-pumpkin
	        overlays: []

	INFO:rity:Looking for a MediaTek SoC matching USB 0e8d:0003

Once you see `Waiting for DA mode`, please :ref:`enter download mode <getting-started/flashing:enter download mode>`.

	1. press and keep pressing the `volume up` button
	2. press and release the `reset` button
	3. release the `volume up` button

You should see the board getting flash immediately after releasing the
`volume up` button.

Flashing only one partition
---------------------------

To flash just one partition, you can run the following command:

.. prompt:: bash $ auto

	$cd rity/build/tmp/deploy/images/<machine>
	$rity-bootrom run-da
	<enter download mode>
	$fastboot flash <partition> <file>

<partition> should be replaced with one of the partition present in the `wic`
file:

 .. literalinclude:: ../../meta/wic/rity.wks
	:linenos:
	:emphasize-lines: 5-7
	:caption: meta/wic/rity.wks

In addition to the partitions defined in the wic, some special partitions are
also available: `mmc0`, `mmc0boot0`, and `mmc0boot1`.

+----------------+------------------------+
| Partition name | File                   |
+================+========================+
| mmc0           | MBR_EMMC               |
+----------------+------------------------+
| mmc0boot0      | bl2.img                |
+----------------+------------------------+
| mmc0boot1      | u-boot-env.bin         |
+----------------+------------------------+
| bootloaders    | fip.bin                |
+----------------+------------------------+
| kernel         | fitImage               |
+----------------+------------------------+
| rootfs         | <image>-<machine>.ext4 |
+----------------+------------------------+
