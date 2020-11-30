# RITY

The RITY repository is a collection of layer in order to demo the usage of the
MediaTek BSP.

## Images

The following images are available:
* `rity-bringup-image`: image that contains the minimal tools for bringing up of new boards
* `rity-demo-image`: image with a lot of tools and applications to make RITY looks more like a full fledged OS

## Building an image

    $ mkdir rity; cd rity
    $ repo init -u git@gitlab.com:baylibre/rich-iot/manifest.git -b rity/gatesgarth
    $ repo sync
    $ export TEMPLATECONF=${PWD}/src/meta-rity/meta/conf/
    $ source src/poky/oe-init-build-env
    $ bitbake rity-demo-image

## Flashing

### Prerequisites

In order for your host machine to be able to talk to the board through USB
without needing root privileges, you need to create a udev rules that will
grant the *plugdev* group access to your device:

    $ echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", ATTR{idProduct}=="201c", MODE="0660", GROUP="plugdev"' | sudo tee -a /etc/udev/rules.d/51-android.rules
    $ sudo udevadm control --reload-rules
    $ sudo udevadm trigger

If your user is not already member of the *plugdev* group:

	$ sudo usermod -a -G plugdev $USER

This last command requires you to log out and log back in to your account to be
in effect.

### Flashing

    $ cd rich-iot/build/tmp/deploy/images/i300a-pumpkin
    $ ./flashimage.py -i rity-demo-image
                                     Checking image
    --------------------------------------------------------------------------------
                                  MBR_EMMC : PASS
                                   bl2.img : PASS
                            u-boot-env.bin : PASS
                                   fip.bin : PASS
                                  fitImage : PASS
        rity-demo-image-i300a-pumpkin.ext4 : PASS

                                     Start flashing
    --------------------------------------------------------------------------------
    Waiting for DA mode
    .

Once you see *Waiting for DA mode*:
1) press the *reset* and *volume up* buttons **simultaneously**
2) then release only the *reset* button
3) release the *volume up* button once you see that the image is getting flashed.

## MediaTek BSP

RITY is meant to be used with `meta-mediatek-bsp`, please check the [BSP README](https://gitlab.com/baylibre/rich-iot/meta-mediatek-bsp/-/blob/HEAD/README.md) to get more information.
