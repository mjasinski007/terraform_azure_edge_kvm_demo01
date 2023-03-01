#cloud-config

packages:
    - bridge-utils
    - qemu-kvm
    - libvirt-daemon-system
    - libvirt-clients
    - inetutils-traceroute
    - iperf3
    - netstat-nat
    - python3
    - python3-googleapi
    - python3-libvirt
    - apt-transport-https
    - unzip
    - git
    - wget
    - curl
    - iputils-ping
    - net-tools
package_upgrade: true
package_reboot_if_required: true
disable_root: false
disable_root_opts: ""

bootcmd:
    - sudo cd /home/ubuntu
    - touch test_file.txt
    - sudo mkdir test_folder






