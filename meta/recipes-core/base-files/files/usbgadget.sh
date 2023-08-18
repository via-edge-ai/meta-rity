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
USB_GADGET_DEFAULT_SN=0123456789
USB_GADGET_MANUFACT="Mediatek Inc."
USB_GADGET_PRODUCT="Genio"
FILE=/etc/usbgadget.conf

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

set_gadget_sn()
{
    # Priority:
    #  1. Use `aiot-flash --serialno` first
    #  2. Load hardware id from optee-ewriter if possible
    #  3. Use static default

    # load from uboot env
    local uboot_serial=`fw_printenv -n serial#`

    # Grab 8-byte hardware identifier with the "ewriter" utility.
    # this requires OP-TEE and optee-ewriter package.
    # The offset 12 and 13 are applicable to Genio SoCs only.
    local optee_hwid=`for i in {12..13}; do ewriter 0 $i 4 | head -n 2 | tail -n 1 | head -c -1; done`

    if [ -n "$uboot_serial" ]
    then
        echo "$uboot_serial" > strings/0x409/serialnumber
        return 0
    fi

    if [ -n "$optee_hwid" ]
    then
        echo "$optee_hwid" > strings/0x409/serialnumber
        return 0
    fi

    echo "$USB_GADGET_DEFAULT_SN" > strings/0x409/serialnumber
}

set_gadget()
{
    cd $USB_GADGET_G1

    echo "$USB_GADGET_BCDUSB" > bcdUSB
    echo "$USB_GADGET_BCDDEV" > bcdDevice
    echo "$USB_GADGET_VID" > idVendor
    echo "$USB_GADGET_PID" > idProduct

    echo "$USB_GADGET_MANUFACT" > strings/0x409/manufacturer
    echo "$USB_GADGET_PRODUCT" > strings/0x409/product

    set_gadget_sn

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

    if [ -f "$FILE" ]; then
        cat $FILE > $USB_GADGET_G1/UDC
    else
        echo $(ls /sys/class/udc) > $USB_GADGET_G1/UDC
    fi

    nmcli connection up usb0
    start-stop-daemon --start --pidfile /run/udhcpd.pid udhcpd /etc/udhcpd.conf
}

stop()
{
    echo "" > $USB_GADGET_G1/UDC
    nmcli connection down usb0
    start-stop-daemon --stop --pidfile /run/udhcpd.pid udhcpd /etc/udhcpd.conf
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
