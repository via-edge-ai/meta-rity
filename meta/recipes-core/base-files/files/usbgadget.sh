#! /bin/sh

USB_GADGET_DEV=/dev/usb-ffs
USB_GADGET_G1=/sys/kernel/config/usb_gadget/g1
USB_GADGET_G1_CONF=$USB_GADGET_G1/configs/c.1
USB_GADGET_G1_FUNC=$USB_GADGET_G1/functions
USB_GADGET_ADB=adb
USB_GADGET_RNDIS=rndis
USB_GADGET_BCDUSB=0x0200
USB_GADGET_BCDDEV=0x0233
USB_GADGET_VID=0x0e8d
USB_GADGET_PID=0x2005
USB_GADGET_SN=0123456789
USB_GADGET_MANUFACT="Mediatek Inc."
USB_GADGET_PRODUCT="AIOT"

create_gadget()
{
    mkdir -p $USB_GADGET_G1

    mkdir -p $USB_GADGET_G1/strings/0x409
    mkdir $USB_GADGET_G1_FUNC/rndis.usb0
    mkdir $USB_GADGET_G1_FUNC/ffs.adb

    mkdir -p $USB_GADGET_G1/strings/0x409
    mkdir -p $USB_GADGET_G1_CONF/strings/0x409

    mkdir $USB_GADGET_DEV -m 770
    mkdir $USB_GADGET_DEV/adb -m 770
}

set_gadget()
{
    cd $USB_GADGET_G1 

    echo "$USB_GADGET_BCDUSB" > bcdUSB
    echo "$USB_GADGET_BCDDEV" > bcdDevice
    echo "$USB_GADGET_VID" > idVendor 
    echo "$USB_GADGET_PID" > idProduct
    echo "$USB_GADGET_SN" > strings/0x409/serialnumber
    echo "$USB_GADGET_MANUFACT" > strings/0x409/manufacturer
    echo "$USB_GADGET_PRODUCT" > strings/0x409/product

    echo 1 > os_desc/use
    echo "MSFT100" > os_desc/qw_sign

    echo $USB_GADGET_RNDIS+$USB_GADGET_ADB > configs/c.1/strings/0x409/configuration

    ln -s functions/rndis.usb0 configs/c.1
    ln -s functions/ffs.adb configs/c.1

    mount -o uid=2000,gid=2000 -t functionfs adb /dev/usb-ffs/adb
    cd -
}

start()
{
    if [ ! -f "$USB_GADGET_G1/UDC" ]
    then 
        create_gadget
    fi

    set_gadget

    start-stop-daemon --start --background --oknodo --quiet --exec /usr/bin/adbd
    sleep 1
    echo $(ls /sys/class/udc) > $USB_GADGET_G1/UDC
}

stop()
{
    echo "" > $USB_GADGET_G1/UDC
    start-stop-daemon --stop --oknodo --quiet --exec /usr/bin/adbd

    rm $USB_GADGET_G1_CONF/rndis.usb0
    rm $USB_GADGET_G1_CONF/ffs.adb
    umount /dev/usb-ffs/adb
}


if [ "$1" = "--start" ]; then
    start
elif [ "$1" = "--stop" ]; then
    stop
fi
