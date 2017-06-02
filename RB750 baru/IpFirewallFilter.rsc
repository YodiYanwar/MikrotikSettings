/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=drop chain=input comment="drop ssh brute forcers" dst-port=22 \
    protocol=tcp src-address-list=ssh_blacklist
add action=drop chain=input comment="drop telnet brute forcers" dst-port=23 \
    protocol=tcp src-address-list=telnet_blacklist
add action=drop chain=input comment="drop ftp brute forcers" dst-port=21 \
    protocol=tcp src-address-list=ftp_blacklist
add action=add-src-to-address-list address-list=ssh_blacklist \
    address-list-timeout=4w2d chain=input comment=ssh_blacklists dst-port=22 \
    protocol=tcp src-address-list=ssh_stage3
add action=add-src-to-address-list address-list=telnet_blacklist \
    address-list-timeout=4w2d chain=input comment=telnet_blacklist dst-port=\
    23 protocol=tcp src-address-list=telnet_stage3
add action=add-src-to-address-list address-list=ftp_blacklist \
    address-list-timeout=4w2d chain=input comment=ftp_blacklist dst-port=21 \
    protocol=tcp src-address-list=ftp_stage3
add action=add-src-to-address-list address-list=ssh_stage3 \
    address-list-timeout=1m chain=input comment=ssh_stage3 dst-port=22 \
    protocol=tcp src-address-list=ssh_stage2
add action=add-src-to-address-list address-list=telnet_stage3 \
    address-list-timeout=1m chain=input comment=telnet_stage3 dst-port=23 \
    protocol=tcp src-address-list=telnet_stage2
add action=add-src-to-address-list address-list=ftp_stage3 \
    address-list-timeout=1m chain=input comment=ftp_stage3 dst-port=21 \
    protocol=tcp src-address-list=ftp_stage2
add action=add-src-to-address-list address-list=ssh_stage2 \
    address-list-timeout=1m chain=input comment=ssh_stage2 dst-port=22 \
    protocol=tcp src-address-list=ssh_stage1
add action=add-src-to-address-list address-list=telnet_stage2 \
    address-list-timeout=1m chain=input comment=telnet_stage2 dst-port=23 \
    protocol=tcp src-address-list=telnet_stage1
add action=add-src-to-address-list address-list=ftp_stage2 \
    address-list-timeout=1m chain=input comment=ftp_stage2 dst-port=21 \
    protocol=tcp src-address-list=ftp_stage1
add action=add-src-to-address-list address-list=ssh_stage3 \
    address-list-timeout=1m chain=input comment=ssh_stage1 dst-port=22 \
    protocol=tcp
add action=add-src-to-address-list address-list=telnet_stage3 \
    address-list-timeout=1m chain=input comment=telnet_stage1 dst-port=23 \
    protocol=tcp
add action=add-src-to-address-list address-list=ftp_stage3 \
    address-list-timeout=1m chain=input comment=ftp_stage1 dst-port=21 \
    protocol=tcp