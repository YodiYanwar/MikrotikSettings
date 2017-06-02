# may/29/2017 09:48:45 by RouterOS 6.34.2
# software id = QSRB-M7II
#
/interface bridge
add name=bridge1-WAN
/interface ethernet
set [ find default-name=ether1 ] name=ether1-NULL
set [ find default-name=ether2 ] name=ether2-LAN
set [ find default-name=ether3 ] name=ether3-ABSEN
set [ find default-name=ether4 ] name=ether4-PC
set [ find default-name=ether5 ] name=ether5-FO
/ip hotspot profile
set [ find default=yes ] html-directory=flash/hotspot
add dns-name=hotspot.matrikulasi.id hotspot-address=192.168.3.1 \
    html-directory=flash/hotspot name=hsprofLAN
/ip hotspot user profile
set [ find default=yes ] rate-limit=15360k/15360k
/ip pool
add name=dhcp_pool1 ranges=192.168.3.2-192.168.3.254
/ip dhcp-server
add address-pool=dhcp_pool1 disabled=no interface=ether2-LAN name=dhcp1
/ip hotspot
add address-pool=dhcp_pool1 disabled=no idle-timeout=none interface=\
    ether2-LAN name=hotspotLAN profile=hsprofLAN
/ip hotspot user profile
add address-list=Mahasiswa address-pool=dhcp_pool1 idle-timeout=20m \
    incoming-packet-mark=packet-mahasiswa-in keepalive-timeout=5m name=\
    Mahasiswa outgoing-packet-mark=packet-mahasiswa-out rate-limit=\
    "450k/450k 768k/768k 512k/512k 8/8" session-timeout=8h transparent-proxy=\
    yes
add address-list=Staff address-pool=dhcp_pool1 idle-timeout=20m \
    incoming-packet-mark=packet-staff-in name=Staff outgoing-packet-mark=\
    packet-staff-out rate-limit="512k/512k 1024k/1024k 768k/768k 10/10" \
    session-timeout=8h shared-users=2 transparent-proxy=yes
add address-list=Pembina address-pool=dhcp_pool1 idle-timeout=20m \
    incoming-packet-mark=packet-pembina-in name=Pembina outgoing-packet-mark=\
    packet-pembina-out rate-limit="512k/512k 1024k/1024k 768k/768k 10/10" \
    session-timeout=8h transparent-proxy=yes
add address-list=Pimpinan address-pool=dhcp_pool1 idle-timeout=20m \
    incoming-packet-mark=packet-pimpinan-in name=Pimpinan \
    outgoing-packet-mark=packet-pimpinan-out rate-limit=\
    "650k/650k 1024k/1024k 815k/815k 10/10" session-timeout=8h shared-users=2 \
    transparent-proxy=yes
add address-list=Dosen address-pool=dhcp_pool1 idle-timeout=2m \
    incoming-packet-mark=packet-dosen-in name=Dosen outgoing-packet-mark=\
    packet-dosen-out rate-limit="512k/512k 1024k/1024k 768k/768k 10/10" \
    session-timeout=8h shared-users=2 transparent-proxy=yes
add address-list=Others address-pool=dhcp_pool1 idle-timeout=20m \
    incoming-packet-mark=packet-others-in name=Others outgoing-packet-mark=\
    packet-others-out rate-limit="150k/150k 300k/300k 256k/256k 5/5" \
    session-timeout=8h transparent-proxy=yes
add address-list=Guest address-pool=dhcp_pool1 idle-timeout=20m \
    incoming-packet-mark=packet-guest-in name=guest outgoing-packet-mark=\
    packet-guest-out rate-limit="512k/512k 1024k/1024k 768k/768k 10/10" \
    session-timeout=1h shared-users=5 transparent-proxy=yes
add address-list="Mahasiswa Atas" address-pool=dhcp_pool1 idle-timeout=20m \
    incoming-packet-mark=packet-mhs-atas-in name="Mahasiswa Atas" \
    outgoing-packet-mark=packet-mhs-atas-out rate-limit=350k/250k \
    session-timeout=8h shared-users=20 transparent-proxy=yes
add address-list=Magang address-pool=dhcp_pool1 idle-timeout=20m \
    incoming-packet-mark=packet-magang-in name=magang outgoing-packet-mark=\
    packet-magang-out rate-limit=384k session-timeout=8h shared-users=10 \
    transparent-proxy=yes
add address-list="Staf 15" address-pool=dhcp_pool1 idle-timeout=1h \
    incoming-packet-mark=packet-staf15-in name=staf-15 outgoing-packet-mark=\
    packet-staf15-out rate-limit=640k session-timeout=8h shared-users=15 \
    transparent-proxy=yes
add address-list=TEST address-pool=dhcp_pool1 incoming-packet-mark=\
    packet-test-in name=TEST outgoing-packet-mark=packet-test-out \
    parent-queue=none rate-limit="512k/512k 1024k/1024k 768k/768k 10/10" \
    transparent-proxy=yes
add address-pool=dhcp_pool1 name=Labkom rate-limit=15360k/15360k \
    session-timeout=1h shared-users=31 transparent-proxy=yes
/interface bridge filter
add action=drop chain=forward dst-port=137-139 in-interface=ether5-FO \
    ip-protocol=tcp log=yes log-prefix="Blok 137-139 Ransomware BRIDGE" \
    mac-protocol=ip
add action=drop chain=forward dst-port=137-139 in-interface=ether5-FO \
    ip-protocol=udp mac-protocol=ip
add action=drop chain=forward dst-port=445 in-interface=ether5-FO \
    ip-protocol=tcp mac-protocol=ip
add action=drop chain=forward dst-port=445 in-interface=ether5-FO \
    ip-protocol=udp mac-protocol=ip
add action=drop chain=forward dst-port=3389 in-interface=ether5-FO \
    ip-protocol=tcp mac-protocol=ip
add action=drop chain=forward dst-port=3389 in-interface=ether5-FO \
    ip-protocol=udp mac-protocol=ip
/interface bridge port
add bridge=bridge1-WAN interface=ether4-PC
add bridge=bridge1-WAN interface=ether3-ABSEN
add bridge=bridge1-WAN interface=ether5-FO
/ip address
add address=103.60.180.186/29 interface=ether5-FO network=103.60.180.184
add address=192.168.3.1/24 interface=ether2-LAN network=192.168.3.0
/ip dhcp-server network
add address=192.168.3.0/24 gateway=192.168.3.1
/ip dns
set servers=119.18.156.10,119.18.152.10
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
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
add action=drop chain=forward dst-port=137-139,445,3389 log=yes log-prefix=\
    "Blok Port Ransomware" protocol=tcp
/ip firewall mangle
add chain=prerouting
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat
/ip hotspot user
add name=admin password=ei2684
add comment="Adi Mulya Suprayogi" name=yogi password=suprayogi
add name=mhs1 password=mhs123 profile=Others server=hotspotLAN
add comment="Yodi Yanwar Staff" name=yodi password=yodieys94 profile=Staff \
    server=hotspotLAN
add comment="Ilyas Doang Staff" name=ilyas password=ilyas784 profile=Staff \
    server=hotspotLAN
add comment="Rusidiana Priatna Staff" name=rusdi password=rusdi253 profile=\
    Pimpinan server=hotspotLAN
add comment="Hasan Ishak Staff" name=hasan password=ishak profile=Pimpinan \
    server=hotspotLAN
add comment="Mimin Mientarsih Staff" name=mimin password=mimin748 profile=\
    Staff server=hotspotLAN
add comment="Ikka Annisa Staff" name=ikka password=ikka395 profile=Staff \
    server=hotspotLAN
add comment="Derry Doang Staff" name=derry password=derry942 profile=Staff \
    server=hotspotLAN
add comment="Afif Zaerofi" name=afif password=afif468 profile=Pimpinan \
    server=hotspotLAN
add comment="Joko Triono Staff" name=joko password=joko205 profile=Staff \
    server=hotspotLAN
add comment=Sulaiman name=sule password=sule853 profile=Staff server=\
    hotspotLAN
add name=nabil password=nabil953 profile=Mahasiswa server=hotspotLAN
add comment="Mas Bro Pardiman Staff" name=pardiman password=pardiman372 \
    profile=Staff server=hotspotLAN
add name=madlino password=madlino564 profile=Mahasiswa server=hotspotLAN
add name=Addieny password=Addieny863 profile=Mahasiswa server=hotspotLAN
add comment="M. Muhlas Others" name=muhlas password=muhlas739 profile=Others \
    server=hotspotLAN
add comment="Atang Suryana Others" name=atang password=atang523 profile=\
    Others server=hotspotLAN
add name=juragan password=ei2684
add comment="Sri Wahyuni" name=sri password=sri734 profile=Pembina server=\
    hotspotLAN
add comment="Siti Rajab" name=rajab password=rajab382 profile=Pembina server=\
    hotspotLAN
add comment="Irwan Sopiyan Others" name=irwan password=irwan583 profile=\
    Others server=hotspotLAN
add comment="Happy Febrina Hariyani" name=happy password=happy842 profile=\
    Dosen server=hotspotLAN
add comment="Didi Dapur Others" name=didi password=didi932 profile=Others \
    server=hotspotLAN
add comment="Saniatun Nurhasanah Pembina" name=sani password=sani482 profile=\
    Pembina server=hotspotLAN
add comment="Kemal Umum Staff" name=kemal password=kemal931 profile=Staff \
    server=hotspotLAN
add comment="Abdul Hamid Pembina" name=hamid2 password=hamid734 profile=\
    Pembina server=hotspotLAN
add name=Wafi password=Wafi591 profile=Mahasiswa server=hotspotLAN
add comment="Ust Abdul Mughni Dosen" name=amughni password=amughni294 \
    profile=Dosen server=hotspotLAN
add comment="Ust Syaichu Dosen" name=syaichu password=syaichu302 profile=\
    Dosen server=hotspotLAN
add comment="Ahmad Fadli Dosen" name=afadli password=afadli157 profile=Dosen \
    server=hotspotLAN
add comment="Asnan Purba Dosen" name=asnanp password=asnanp904 profile=Dosen \
    server=hotspotLAN
add comment="Bohri Rahman Dosen" name=bohri password=bohri574 profile=Dosen \
    server=hotspotLAN
add comment="Dewi Febriani Dosen" name=dewif password=dewif932 profile=Dosen \
    server=hotspotLAN
add comment="Dodi Yarli Dosen" name=dodiy password=dodiy589 profile=Dosen \
    server=hotspotLAN
add comment="Dr. Abdurrahman Misno Dosen" name=amisno password=amisno158 \
    profile=Dosen server=hotspotLAN
add comment="Dr. Arif Rahman Dosen" name=arifrahman password=arifrahman538 \
    profile=Pimpinan server=hotspotLAN
add comment="Dr. Indra Dosen" name=indra2 password=indra2795 profile=Dosen \
    server=hotspotLAN
add comment="Dr. Sugiyarti Fatma Laela Dosen" name=laela password=laela112 \
    profile=Dosen server=hotspotLAN
add comment="Edi Chandra Dosen" name=echandra password=echandra749 profile=\
    Dosen server=hotspotLAN
add comment="Endiana Dwi Muharani Dosen" name=endiana password=endiana625 \
    profile=Dosen server=hotspotLAN
add comment="Eppy Komalasari Dosen" name=eppy password=eppy980 profile=Dosen \
    server=hotspotLAN
add comment="Grandis Imamahendra Dosen" name=grandis password=grandis347 \
    profile=Dosen server=hotspotLAN
add comment="Harliani Djajasukanta Dosen" name=harliani password=harliani213 \
    profile=Dosen server=hotspotLAN
add comment="Hera Herdiansyah Dosen" name=hera2 password=hera2647 profile=\
    Dosen server=hotspotLAN
add comment="Iris Windu Pravitri Dosen" name=iris password=iris247 profile=\
    Dosen server=hotspotLAN
add comment="Ita Rospita Darwis Dosen" name=irospita password=irospita854 \
    profile=Dosen server=hotspotLAN
add comment="Khairunisa Dosen" name=khairunisa password=khairunisa483 \
    profile=Dosen server=hotspotLAN
add comment="Miftakhus Surur Dosen" name=surur password=surur682 profile=\
    Dosen server=hotspotLAN
add comment="Muhammad Isa Dosen" name=isa32 password=isa3256 profile=Dosen \
    server=hotspotLAN
add comment="Muljono Muah Dosen" name=muah password=muah4945 profile=Dosen \
    server=hotspotLAN
add comment="Nasher Akbar Dosen" name=nasher2 password=nasher2295 profile=\
    Dosen server=hotspotLAN
add comment="Sopyan Munawar Dosen" name=sopyanm password=sopyanm534 profile=\
    Dosen server=hotspotLAN
add comment="Syamsul Hadi Dosen" name=shadi password=shadi935 profile=Dosen \
    server=hotspotLAN
add comment="Unang Fauzi Dosen" name=ufauzi password=ufauzi000 profile=Dosen \
    server=hotspotLAN
add comment="Wisnu Tanggap Prabowo Dosen" name=wisnu password=wisnu856 \
    profile=Dosen server=hotspotLAN
add name=akbar password=akbar394 profile=Pembina server=hotspotLAN
add name=diva password=diva839 profile=Pembina server=hotspotLAN
add name=adita password=adita467 profile=Pembina server=hotspotLAN
add name=aya password=aya384 profile=Pembina server=hotspotLAN
add name=ammar password=ammar849 profile=Pembina server=hotspotLAN
add name=rizky password=rizky394 profile=Pembina server=hotspotLAN
add comment="Heriyandi Others" name=andi2 password=andi248 profile=Others \
    server=hotspotLAN
add comment="Yudi Wahyudi Others" name=wahyudi2 password=wahyudi239 profile=\
    Others server=hotspotLAN
add name=anwar2 password=anwar295 profile=Pembina server=hotspotLAN
add comment="Achmad Syairul Dosen" name=syairul password=syairul643 profile=\
    Dosen server=hotspotLAN
add comment="Iwan Sunarya Dosen" name=sunarya password=sunarya466 profile=\
    Dosen server=hotspotLAN
add comment="Joni Qodariyanto Dosen" name=joni password=joni495 profile=Dosen \
    server=hotspotLAN
add comment="Rizaludin Dosen" name=rizaludin password=rizaludin126 profile=\
    Dosen server=hotspotLAN
add comment="Ummu Hanik Dosen" name=hanik password=hanik684 profile=Dosen \
    server=hotspotLAN
add comment="Rohendi Others" name=hendi2 password=hendi245 profile=Others \
    server=hotspotLAN
add comment="Syahrul Rodji Others" name=syahrul2 password=syahrul203 profile=\
    Others server=hotspotLAN
add disabled=yes name=mhsatas password=mhsatas123 profile="Mahasiswa Atas" \
    server=hotspotLAN
add comment="Oki Satriyan Seno Staff" name=oki password=oki523 profile=Staff \
    server=hotspotLAN
add comment="Muhammad Isa Dosen" name=m.isa password=isa222 profile=Dosen \
    server=hotspotLAN
add comment="nano Others" name=nano password=nano452 profile=Others server=\
    hotspotLAN
add name=rafly1 password=mumu99 profile=Others server=hotspotLAN
add comment="Berry Irawan Others" name=berry password=berry profile=Others \
    server=hotspotLAN
add comment="Khusus Anak Magang" name=magang password=magang123 profile=\
    magang server=hotspotLAN
add comment="Khusus Tamu" name=tamu password=tamu123 profile=Others server=\
    hotspotLAN
add name=dwi password=dwi486 profile=Mahasiswa server=hotspotLAN
add name=azizah password=azizah222 profile=Mahasiswa server=hotspotLAN
add name=khodijah password=kohdijah452 profile=Mahasiswa server=hotspotLAN
add name=rahmi password=rahmi753 profile=Mahasiswa server=hotspotLAN
add name=sophia password=sophia845 profile=Mahasiswa server=hotspotLAN
add name=nurul password=nurul152 profile=Mahasiswa server=hotspotLAN
add name=eleina password=eleina258 profile=Mahasiswa server=hotspotLAN
add name=annisa password=annisa754 profile=Mahasiswa server=hotspotLAN
add name=aisyah password=aisyah147 profile=Mahasiswa server=hotspotLAN
add name=maharani password=maharani487 profile=Mahasiswa server=hotspotLAN
add name=delvia password=delvia714 profile=Mahasiswa server=hotspotLAN
add name=hariri password=hariri354 profile=Mahasiswa server=hotspotLAN
add name=anjariani password=anjariani264 profile=Mahasiswa server=hotspotLAN
add name=novia password=novia861 profile=Mahasiswa server=hotspotLAN
add name=dina password=dina601 profile=Mahasiswa server=hotspotLAN
add name=intan password=intan425 profile=Mahasiswa server=hotspotLAN
add name=wahyudi password=wahyudi746 profile=Mahasiswa server=hotspotLAN
add name=agung password=agung157 profile=Mahasiswa server=hotspotLAN
add name=maulana password=maulana482 profile=Mahasiswa server=hotspotLAN
add name=bayu password=bayu705 profile=Mahasiswa server=hotspotLAN
add name=raditya password=raditya785 profile=Mahasiswa server=hotspotLAN
add name=hafiz password=hafiz516 profile=Mahasiswa server=hotspotLAN
add name=irfan password=irfan164 profile=Mahasiswa server=hotspotLAN
add name=restu password=restu712 profile=Mahasiswa server=hotspotLAN
add name=iqbal password=iqbal147 profile=Mahasiswa server=hotspotLAN
add name=luthfi password=luthfi249 profile=Mahasiswa server=hotspotLAN
add name=zein password=zein784 profile=Mahasiswa server=hotspotLAN
add name=habib password=habib792 profile=Mahasiswa server=hotspotLAN
add name=alwi password=alwi543 profile=Mahasiswa server=hotspotLAN
add name=radityo password=radityo721 profile=Mahasiswa server=hotspotLAN
add name=hamdi password=hamdi137 profile=Mahasiswa server=hotspotLAN
add name=ghifari password=ghifari731 profile=Mahasiswa server=hotspotLAN
add name=thufei password=thufei346 profile=Mahasiswa server=hotspotLAN
add name=raffi password=raffi164 profile=Mahasiswa server=hotspotLAN
add name=robbani password=robbani584 profile=Mahasiswa server=hotspotLAN
add name="ariq " password=ariq249 profile=Mahasiswa server=hotspotLAN
add name=ehza password=ehza685 profile=Mahasiswa server=hotspotLAN
add name=bahrudin password=bahrudin629 profile=Mahasiswa server=hotspotLAN
add name=afandi password=afandi486 profile=Mahasiswa server=hotspotLAN
add name=komarudin password=komarudin246 profile=Mahasiswa server=hotspotLAN
add name=aris password=aris345 profile=Mahasiswa server=hotspotLAN
add name=wiratama password=wiratama681 profile=Mahasiswa server=hotspotLAN
add name=farid password=farid638 profile=Mahasiswa server=hotspotLAN
add name=fadhil password=fadhil846 profile=Mahasiswa server=hotspotLAN
add name=muaz password=muaz851 profile=Mahasiswa server=hotspotLAN
add name=syami password=syami854 profile=Mahasiswa server=hotspotLAN
add name=ilham password=ilham164 profile=Mahasiswa server=hotspotLAN
add name=fuadi password=fuadi423 profile=Mahasiswa server=hotspotLAN
add name=idris password=idris754 profile=Mahasiswa server=hotspotLAN
add name=hananul password=hananul586 profile=Mahasiswa server=hotspotLAN
add name=saeful password=saeful854 profile=Mahasiswa server=hotspotLAN
add name=aldei password=aldei742 profile=Mahasiswa server=hotspotLAN
add name=haikal password=haikal256 profile=Mahasiswa server=hotspotLAN
add name=ghafarullah password=ghafarullah682 profile=Mahasiswa server=\
    hotspotLAN
add name=adlan password=adlan964 profile=Mahasiswa server=hotspotLAN
add name=abdullah password=abdullah862 profile=Mahasiswa server=hotspotLAN
add name="iqbal z" password=iqbalz785 profile=Mahasiswa server=hotspotLAN
add name=ahmad password=ahmad458 profile=Mahasiswa server=hotspotLAN
add name=javier password=javier564 profile=Mahasiswa server=hotspotLAN
add name=azmie password=azmie349 profile=Mahasiswa server=hotspotLAN
add name=febby password=febby956 profile=Mahasiswa server=hotspotLAN
add name=faqih password=faqih153 profile=Mahasiswa server=hotspotLAN
add name=musyaffa password=musyaffa624 profile=Mahasiswa server=hotspotLAN
add name=farhan password=farhan109 profile=Mahasiswa server=hotspotLAN
add name=aprian password=aprian741 profile=Mahasiswa server=hotspotLAN
add name=roby password=roby582 profile=Mahasiswa server=hotspotLAN
add name=anwar password=anwar194 profile=Mahasiswa server=hotspotLAN
add name=shiddiqi password=shiddiqi527 profile=Mahasiswa server=hotspotLAN
add name=alvin password=alvin864 profile=Mahasiswa server=hotspotLAN
add name=yahya password=yahya298 profile=Mahasiswa server=hotspotLAN
add name=dedra password=dedra253 profile=Mahasiswa server=hotspotLAN
add name=suhardi password=suhardi429 profile=Mahasiswa server=hotspotLAN
add name=ihsan password=ihsan806 profile=Mahasiswa server=hotspotLAN
add name=salman password=salman241 profile=Mahasiswa server=hotspotLAN
add name=taufik password=taufik485 profile=Mahasiswa server=hotspotLAN
add name=paiz password=paiz348 profile=Mahasiswa server=hotspotLAN
add name=rifki password=rifki437 profile=Mahasiswa server=hotspotLAN
add name=taqiyya password=taqiyya614 profile=Mahasiswa server=hotspotLAN
add name=waqi password=waqi796 profile=Mahasiswa server=hotspotLAN
add name=fakhri password=fakhari209 profile=Mahasiswa server=hotspotLAN
add name=fahmi password=fahmi214 profile=Mahasiswa server=hotspotLAN
add name=Hamzah password=Hamzah843 profile=Mahasiswa server=hotspotLAN
add name=Syahdi password=Syahdi173 profile=Mahasiswa server=hotspotLAN
add name=Mardani password=Mardani504 profile=Mahasiswa server=hotspotLAN
add name=Aslam password=Aslam617 profile=Mahasiswa server=hotspotLAN
add name=Nadia password=Nadia342 profile=Mahasiswa server=hotspotLAN
add name=Laila password=Laila453 profile=Mahasiswa server=hotspotLAN
add name=Aghna password=Aghna416 profile=Mahasiswa server=hotspotLAN
add name=Aini password=Aini349 profile=Mahasiswa server=hotspotLAN
add name=Ria password=Ria846 profile=Mahasiswa server=hotspotLAN
add name=Ghea password=Ghea946 profile=Mahasiswa server=hotspotLAN
add name=Mona password=Mona876 profile=Mahasiswa server=hotspotLAN
add name=Koriatin password=Koriatin741 profile=Mahasiswa server=hotspotLAN
add name=Fiskasari password=Fiskasari954 profile=Mahasiswa server=hotspotLAN
add name=Hilyatil password=Hilyatil751 profile=Mahasiswa server=hotspotLAN
add name=Zahra password=Zahra368 profile=Mahasiswa server=hotspotLAN
add name=Farras password=Farras359 profile=Mahasiswa server=hotspotLAN
add name=Aliyah password=Aliyah584 profile=Mahasiswa server=hotspotLAN
add name=Madania password=Madania153 profile=Mahasiswa server=hotspotLAN
add name=Junata password=Junata495 profile=Mahasiswa server=hotspotLAN
add name=Saidah password=Saidah682 profile=Mahasiswa server=hotspotLAN
add name=Mulfaizah password=Mulfaizah469 profile=Mahasiswa server=hotspotLAN
add name=Nabilah password=Nabilah785 profile=Mahasiswa server=hotspotLAN
add name=Aulia password=Aulia349 profile=Mahasiswa server=hotspotLAN
add name=Alfiani password=Alfiani498 profile=Mahasiswa server=hotspotLAN
add name=Rizkia password=Rizkia347 profile=Mahasiswa server=hotspotLAN
add name=Salma password=Salma761 profile=Mahasiswa server=hotspotLAN
add name=Hanifah password=Hanifah735 profile=Mahasiswa server=hotspotLAN
add name=Mutia password=Mutia157 profile=Mahasiswa server=hotspotLAN
add name=Fathi password=Fathi825 profile=Mahasiswa server=hotspotLAN
add name=Ayudia password=Ayudia941 profile=Mahasiswa server=hotspotLAN
add name=Robbani password=Robbani852 profile=Mahasiswa server=hotspotLAN
add name=Widya password=Widya485 profile=Mahasiswa server=hotspotLAN
add name=Sakinah password=Sakinah196 profile=Mahasiswa server=hotspotLAN
add name=Syiffa password=Syiffa579 profile=Mahasiswa server=hotspotLAN
add name=Azkia password=Azkia795 profile=Mahasiswa server=hotspotLAN
add name=Adellia password=Adellia349 profile=Mahasiswa server=hotspotLAN
add name=Zahidah password=Zahidah864 profile=Mahasiswa server=hotspotLAN
add name=Eisha password=Eisha654 profile=Mahasiswa server=hotspotLAN
add name=Fadillah password=Fadillah794 profile=Mahasiswa server=hotspotLAN
add name=Sekar password=Sekar643 profile=Mahasiswa server=hotspotLAN
add name=Rima password=Rima573 profile=Mahasiswa server=hotspotLAN
add name=Soraya password=Soraya539 profile=Mahasiswa server=hotspotLAN
add name=Putri password=Putri849 profile=Mahasiswa server=hotspotLAN
add name=Pratidina password=Pratidina846 profile=Mahasiswa server=hotspotLAN
add name=Riski password=Riski842 profile=Mahasiswa server=hotspotLAN
add name=Zalika password=Zalika561 profile=Mahasiswa server=hotspotLAN
add name=Miranti password=Miranti profile=Mahasiswa server=hotspotLAN
add name=Pakarti password=Pakarti795 profile=Mahasiswa server=hotspotLAN
add name=Fadhillah password=Fadhillah754 profile=Mahasiswa server=hotspotLAN
add name=Febriani password=Febriani954 profile=Mahasiswa server=hotspotLAN
add name=Fauziah password=Fauziah854 profile=Mahasiswa server=hotspotLAN
add name=Darwiwing password=Darwiwing246 profile=Mahasiswa server=hotspotLAN
add name=Yustifa password=Yustifa486 profile=Mahasiswa server=hotspotLAN
add name=Wahyu password=wahyu958 profile=Mahasiswa server=hotspotLAN
add name=tariq password=tariq294 profile=Mahasiswa server=hotspotLAN
add name=Khairu password=Khairu594 profile=Mahasiswa server=hotspotLAN
add name=Medina password=Medina298 profile=Mahasiswa server=hotspotLAN
add name=Khonsa password=khonsa123 profile=Mahasiswa server=hotspotLAN
add name=Alfaizi password=Alfaizi261 profile=Mahasiswa server=hotspotLAN
add name=Vindi password=Vindi236 profile=Mahasiswa server=hotspotLAN
add name=Brenda password=Brenda128 profile=Mahasiswa server=hotspotLAN
add name=Bagus password=Bagus238 profile=Mahasiswa server=hotspotLAN
add name=Aliefiyani password=Aliefiyani158 profile=Mahasiswa server=\
    hotspotLAN
add name=Sayyidah password=Sayyidah291 profile=Mahasiswa server=hotspotLAN
add name=Alfafa password=Alfafa861 profile=Mahasiswa server=hotspotLAN
add name=Emonika password=Emonika584 profile=Mahasiswa server=hotspotLAN
add name=Uttami password=Uttami736 profile=Mahasiswa server=hotspotLAN
add name=Hanun password=Hanun729 profile=Mahasiswa server=hotspotLAN
add name=Furaizha password=Furaizha647 profile=Mahasiswa server=hotspotLAN
add name=Indah password=Indah592 profile=Mahasiswa server=hotspotLAN
add name=Aristi password=Aristi829 profile=Mahasiswa server=hotspotLAN
add name=Rahmawati password=Rahmawati527 profile=Mahasiswa server=hotspotLAN
add name=Fanny password=Fanny953 profile=Mahasiswa server=hotspotLAN
add name=Tamimi password=Tamimi319 profile=Mahasiswa server=hotspotLAN
add name=Adela password=Adela693 profile=Mahasiswa server=hotspotLAN
add name=Nabil password=Nabil846 profile=Mahasiswa server=hotspotLAN
add name=Suherlan password=Suherlan248 profile=Mahasiswa server=hotspotLAN
add name=Fauzan password=Fauzan368 profile=Mahasiswa server=hotspotLAN
add name=Tegar password=Tegar794 profile=Mahasiswa server=hotspotLAN
add name=Iftikhor password=Iftikhor542 profile=Mahasiswa server=hotspotLAN
add name=Ainal password=Ainal394 profile=Mahasiswa server=hotspotLAN
add name=Alfauzan password=Alfauzan258 profile=Mahasiswa server=hotspotLAN
add name=Annisatul password=Annisatul274 profile=Mahasiswa server=hotspotLAN
add name=Krisna password=Krisna240 profile=Mahasiswa server=hotspotLAN
add name=syahfrul password="Syahrul 846" profile=Mahasiswa server=hotspotLAN
add name=Farrastyo password=Farrastyo864 profile=Mahasiswa server=hotspotLAN
add name=Reinaldi password=Reinaldi642 profile=Mahasiswa server=hotspotLAN
add name=Muzakki password=Muzakki208 profile=Mahasiswa server=hotspotLAN
add name=nur password=nur793 profile=Mahasiswa server=hotspotLAN
add name=Ivan password=Ivan784 profile=Mahasiswa server=hotspotLAN
add name=Aunul password=Aunul792 profile=Mahasiswa server=hotspotLAN
add name=Ardika password=Ardika275 profile=Mahasiswa server=hotspotLAN
add name=Shiddiq password=Shiddiq931 profile=Mahasiswa server=hotspotLAN
add name=Muqtadir password=Muqtadir528 profile=Mahasiswa server=hotspotLAN
add name=Edwin password=Edwin851 profile=Mahasiswa server=hotspotLAN
add name=Bramantyo password=Bramantyo861 profile=Mahasiswa server=hotspotLAN
add name=naufal password=naufal975 profile=Mahasiswa server=hotspotLAN
add name=Khatami password=khatami294 profile=Mahasiswa server=hotspotLAN
add name=M.Fauzan password=M.Fauzan951 profile=Mahasiswa server=hotspotLAN
add name=Akbar password=Akbar958 profile=Mahasiswa server=hotspotLAN
add name=Zikrul password=Zikrul749 profile=Mahasiswa server=hotspotLAN
add name=Fadhil password=Fadhil594 profile=Mahasiswa server=hotspotLAN
add name=Fadhilah password=Fadhilah284 profile=Mahasiswa server=hotspotLAN
add name=Nadiyah password=Nadiyah475 profile=Mahasiswa server=hotspotLAN
add name=Tarini password=Tarini652 profile=Mahasiswa server=hotspotLAN
add name=andi password=andi264 profile=Mahasiswa server=hotspotLAN
add name=Ireta password=Ireta849 profile=Mahasiswa server=hotspotLAN
add name=Humairah password=humairah746 profile=Mahasiswa server=hotspotLAN
add name=Anggianisah password=Anggianisah946 profile=Mahasiswa server=\
    hotspotLAN
add name=Khair password=Khair841 profile=Mahasiswa server=hotspotLAN
add name=Amalia password=Amalia235 profile=Mahasiswa server=hotspotLAN
add name=Kurniawati password=Kurniawati239 profile=Mahasiswa server=\
    hotspotLAN
add name=Rahil password=Rahil253 profile=Mahasiswa server=hotspotLAN
add name=Astikah password=Astikah853 profile=Mahasiswa server=hotspotLAN
add name=Syafira password=Syafira085 profile=Mahasiswa server=hotspotLAN
add name=Karimah password=Karimah790 profile=Mahasiswa server=hotspotLAN
add name=Siti password=Siti420 profile=Mahasiswa server=hotspotLAN
add name=Shalihah password=Shalihah294 profile=Mahasiswa server=hotspotLAN
add name=Fahimah password=Fahimah846 profile=Mahasiswa server=hotspotLAN
add name=Faya password=Faya462 profile=Mahasiswa server=hotspotLAN
add name=Hayati password=Hayati493 profile=Mahasiswa server=hotspotLAN
add name=Khasanah password=Khasanah564 profile=Mahasiswa server=hotspotLAN
add name=Arsha password=Arsha236 profile=Mahasiswa server=hotspotLAN
add name=Novalina password=Novalina872 profile=Mahasiswa server=hotspotLAN
add name=Dara password=dara284 profile=Mahasiswa server=hotspotLAN
add name=Zhafirah password=Zhafirah584 profile=Mahasiswa server=hotspotLAN
add name=Agustin password=Agustin846 profile=Mahasiswa server=hotspotLAN
add name=Balqia password=Balqia480 profile=Mahasiswa server=hotspotLAN
add name=Azzahrah password=Azzahrah510 profile=Mahasiswa server=hotspotLAN
add name=Kartikasari password=Kartikasari946 profile=Mahasiswa server=\
    hotspotLAN
add name=Dani password=Dani750 profile=Mahasiswa server=hotspotLAN
add name=Thufailmubarak password=Thufailmubarak820 profile=Mahasiswa server=\
    hotspotLAN
add name=Atiqah password=Atiqah561 profile=Mahasiswa server=hotspotLAN
add name=Tsuraya password=Tsuraya749 profile=Mahasiswa server=hotspotLAN
add name=Nurhawary password=Nurhawary854 profile=Mahasiswa server=hotspotLAN
add name=Afif password=Afif708 profile=Mahasiswa server=hotspotLAN
add name=Robiatul password=Robiatul975 profile=Mahasiswa server=hotspotLAN
add name=Yumna password=Yumna749 profile=Mahasiswa server=hotspotLAN
add name=Wadi password=Wadi153 profile=Mahasiswa server=hotspotLAN
add name=Alifia password=Alifia830 profile=Mahasiswa server=hotspotLAN
add name=Ayussnita password=Ayussnita749 profile=Mahasiswa server=hotspotLAN
add name=Rohmayanti password=Rohmayanti409 profile=Mahasiswa server=\
    hotspotLAN
add name=Annisa password=Annisa579 profile=Mahasiswa server=hotspotLAN
add name=Agung password=Agung943 profile=Mahasiswa server=hotspotLAN
add name=Qodri password=Qodri395 profile=Mahasiswa server=hotspotLAN
add name=Zacky password=Zacky593 profile=Mahasiswa server=hotspotLAN
add name=Bilal password=Bilal756 profile=Mahasiswa server=hotspotLAN
add name=Najjmurrahman password=Najjmurrahman591 profile=Mahasiswa server=\
    hotspotLAN
add name=Sobriyana password=Sobriyana497 profile=Mahasiswa server=hotspotLAN
add name=Misluha password=Misluha185 profile=Mahasiswa server=hotspotLAN
add name=Wijaya password=Wijaya759 profile=Mahasiswa server=hotspotLAN
add name=Yusuf password=Yusuf830 profile=Mahasiswa server=hotspotLAN
add name=Haris password=Haris076 profile=Mahasiswa server=hotspotLAN
add name=Hanafi password=Hanafi853 profile=Mahasiswa server=hotspotLAN
add name=Satria password=Satria648 profile=Mahasiswa server=hotspotLAN
add name=Rasvi password=Rasvi839 profile=Mahasiswa server=hotspotLAN
add name=hafidzakbar password=hafidzakbar738 profile=Mahasiswa server=\
    hotspotLAN
add name=Asyraf password=Asyraf249 profile=Mahasiswa server=hotspotLAN
add name=Athif password=Athif915 profile=Mahasiswa server=hotspotLAN
add name=Gunawan password=Gunawan830 profile=Mahasiswa server=hotspotLAN
add name=Mulki password=Mulki305 profile=Mahasiswa server=hotspotLAN
add name=Danti password=Danti807 profile=Mahasiswa server=hotspotLAN
add name=Munira password=Munira834 profile=Mahasiswa server=hotspotLAN
add name=Herdayanti password=Herdayanti964 profile=Mahasiswa server=\
    hotspotLAN
add name=Fikriani password=Fikriani946 profile=Mahasiswa server=hotspotLAN
add name=Nurhuda password=Nurhuda738 profile=Mahasiswa server=hotspotLAN
add name=salsabila password=salsabila294 profile=Mahasiswa server=hotspotLAN
add name=Sarah password=Sarah529 profile=Mahasiswa server=hotspotLAN
add name=Naufal password=Naufal924 profile=Mahasiswa server=hotspotLAN
add name=Fikar password=Fikar482 profile=Mahasiswa server=hotspotLAN
add name=Lazuardi password=Lazuardi431 profile=Mahasiswa server=hotspotLAN
add name=Nada password=Nada319 profile=Mahasiswa server=hotspotLAN
add name=Sahara password=Sahara249 profile=Mahasiswa server=hotspotLAN
add name=Nurmalia password=Nurmalia253 profile=Mahasiswa server=hotspotLAN
add name=Atikah password=Atikah240 profile=Mahasiswa server=hotspotLAN
add name=Kamalasari password=Kamalasari482 profile=Mahasiswa server=\
    hotspotLAN
add name=Rizal password=Rizal471 profile=Mahasiswa server=hotspotLAN
add comment="Neng Sri Hartati Staff" name=neng password=srih profile=Staff \
    server=hotspotLAN
add comment="Siti Solihatul Munfariha Staff" name=siti password=siti637 \
    profile=Staff server=hotspotLAN
add disabled=yes name=rosid password=rosid123
add comment="Andang Heryahya" name=andang password=andang483 profile=Dosen \
    server=hotspotLAN
add name=Fadilla password=Fadilla592 profile=Mahasiswa server=hotspotLAN
add name=Rony password=Rony784 profile=Mahasiswa server=hotspotLAN
add name=Fathan password=Fathan620 profile=Mahasiswa server=hotspotLAN
add name=galih password=galih576 profile=Dosen server=hotspotLAN
add name=Cahya password=Cahya381 profile=Mahasiswa server=hotspotLAN
add name=arip password=arip015 profile=Mahasiswa server=hotspotLAN
add name=burst password=bursttest123 profile=TEST server=hotspotLAN
add name=Jordi password=Jordi361 profile=Mahasiswa server=hotspotLAN
add name=andika password=andika516 profile=Mahasiswa server=hotspotLAN
add name=Raihan password=Raihan197 profile=Mahasiswa server=hotspotLAN
add name=ghifariyadi password=ghifariyadi852 profile=Mahasiswa server=\
    hotspotLAN
add name=labkom password=labkomro3795 profile=Labkom server=hotspotLAN
add name=fatin password=fatin785 profile=Mahasiswa server=hotspotLAN
add name=refah password=refah357 profile=Mahasiswa server=hotspotLAN
/ip route
add distance=1 gateway=103.60.180.185
/system clock
set time-zone-name=Asia/Jakarta
/system identity
set name="CPE -TAZKIA DRAMAGA"
/system routerboard settings
set cpu-frequency=850MHz protected-routerboot=disabled
