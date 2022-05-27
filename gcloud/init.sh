#!/bin/bash
if [ $EUID -eq 0 ]; then
    echo "gcloud/init.sh"
    echo "Setting up as a root..."

    echo "Checking if already configured"
    FLAG="/var/log/easy-free5gc"
    #Delete this if you want to manually re-run the script
    if [[ -f $FLAG ]]; then
        echo "Already configured, exiting"
        exit
    fi

    #set up flag so the script executes only on a first boot
    touch "$FLAG"

    USER="free5gc-user"
    echo "Creating '$USER' user..."
    useradd $USER -m -s /bin/bash
    echo -e "$USER:admin" | chpasswd
    echo -e "$USER ALL = NOPASSWD : ALL" >> /etc/sudoers

    apt update
    apt install git

    cd /home/$USER/
    echo "Removing easy-free5gc repository if it exists..."
    rm -rf easy-free5gc 2> /dev/null
    git clone https://github.com/konradkar2/easy-free5gc

    chown $USER easy-free5gc -R
    chmod 777 easy-free5gc -R

    #run new bash process as USER
    exec sudo -u "$USER" -i easy-free5gc/common/init.sh -- "$@"

    exit
fi

echo "Should be run as root"
exit -1