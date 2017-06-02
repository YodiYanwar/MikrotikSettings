# apr/20/2017 14:56:21 by RouterOS 6.30.4
# software id = R898-P49V
#
/interface bridge
add comment="Jaringan LAN" name=bridge-LAN
add name=bridge-WAN
/interface ethernet
set [ find default-name=ether1 ] mac-address=D4:CA:6D:03:D4:A5 name=\
    ether1-LAN
set [ find default-name=ether2 ] mac-address=D4:CA:6D:03:D4:A6 name=\
    ether2-ABSEN
set [ find default-name=ether3 ] mac-address=D4:CA:6D:03:D4:A7 name=\
    ether3-LAN
set [ find default-name=ether4 ] mac-address=D4:CA:6D:03:D4:A8 name=\
    ether4-LAN
set [ find default-name=ether5 ] mac-address=D4:CA:6D:03:D4:A9 name=\
    ether5-WAN
/ip neighbor discovery
set bridge-LAN comment="Jaringan LAN"
/interface vlan
add interface=bridge-LAN l2mtu=1518 name=vlanAdmin vlan-id=11
add interface=bridge-LAN l2mtu=1518 name=vlanLecturer vlan-id=44
add interface=bridge-LAN l2mtu=1518 name=vlanStaff vlan-id=22
add interface=bridge-LAN l2mtu=1518 name=vlanStudent vlan-id=33
/ip hotspot profile
set [ find default=yes ] dns-name=hotspot.matrikulasi.id hotspot-address=\
    192.168.3.1 html-directory=flash/hotspot
add hotspot-address=192.168.3.1 name=hsprofLAN
add hotspot-address=192.168.11.1 name=hsprofAdmin
add hotspot-address=192.168.22.1 name=hsprofStaff
add hotspot-address=192.168.33.1 name=hsprofStudent
add hotspot-address=192.168.44.1 name=hsprofLecturer
/ip hotspot user profile
set [ find default=yes ] rate-limit=15360k/15360k shared-users=2
add idle-timeout=20m keepalive-timeout=5m name=Mahasiswa rate-limit=400k/350k \
    session-timeout=8h transparent-proxy=yes
add idle-timeout=20m name=Staff rate-limit=512k/400k session-timeout=8h \
    transparent-proxy=yes
add idle-timeout=20m name=Pembina rate-limit=512k/400k session-timeout=8h \
    transparent-proxy=yes
add idle-timeout=20m name=Pimpinan rate-limit=650k/650k session-timeout=8h \
    shared-users=2 transparent-proxy=yes
add idle-timeout=2m name=Dosen rate-limit=512k/400k session-timeout=8h \
    transparent-proxy=yes
add idle-timeout=20m name=Others rate-limit=150k/128k session-timeout=8h \
    transparent-proxy=yes
add idle-timeout=20m name=guest rate-limit=512k/512k session-timeout=1h \
    shared-users=5 transparent-proxy=yes
add idle-timeout=20m name="Mahasiswa Atas" rate-limit=350k/250k \
    session-timeout=8h shared-users=20 transparent-proxy=yes
add idle-timeout=20m name=magang rate-limit=384k session-timeout=8h \
    shared-users=10 transparent-proxy=yes
add idle-timeout=1h name=staf-15 rate-limit=640k session-timeout=8h \
    shared-users=15 transparent-proxy=yes
/ip pool
add name=dhcp_pool2 ranges=192.168.3.2-192.168.3.254
add name=pool-03 ranges=192.168.3.101-192.168.3.200
add name=pool-11 ranges=192.168.11.2-192.168.11.254
add name=pool-22 ranges=192.168.22.2-192.168.22.254
add name=pool-33 ranges=192.168.33.2-192.168.33.254
add name=pool-44 ranges=192.168.44.2-192.168.44.254
/ip dhcp-server
add address-pool=pool-03 disabled=no interface=bridge-LAN name=dhcp2
add address-pool=pool-11 disabled=no interface=vlanAdmin lease-time=30m name=\
    dhcp1
add address-pool=pool-22 disabled=no interface=vlanStaff lease-time=30m name=\
    dhcp3
add address-pool=pool-33 disabled=no interface=vlanStudent lease-time=30m \
    name=dhcp4
add address-pool=pool-44 disabled=no interface=vlanLecturer lease-time=30m \
    name=dhcp5
/ip hotspot
add address-pool=pool-03 disabled=no interface=bridge-LAN name=hotspotLAN \
    profile=hsprofLAN
add address-pool=pool-11 disabled=no interface=vlanAdmin name=hs-vlanAdmin \
    profile=hsprofAdmin
add address-pool=pool-22 disabled=no interface=vlanStaff name=hs-vlanStaff \
    profile=hsprofStaff
add address-pool=pool-33 disabled=no interface=vlanStudent name=\
    hs-vlanStudent profile=hsprofStudent
add address-pool=pool-44 disabled=no interface=vlanLecturer name=\
    hs-vlanLecturer profile=hsprofLecturer
/interface bridge port
add bridge=bridge-WAN interface=ether5-WAN
add bridge=bridge-WAN interface=ether2-ABSEN
add bridge=bridge-LAN interface=ether3-LAN
add bridge=bridge-LAN interface=ether1-LAN
add bridge=bridge-LAN interface=ether4-LAN
/ip address
add address=103.60.180.186/29 interface=ether5-WAN network=103.60.180.184
add address=192.168.3.1/24 disabled=yes interface=ether1-LAN network=\
    192.168.3.0
add address=192.168.3.1/24 comment="Jaringan LAN" interface=bridge-LAN \
    network=192.168.3.0
add address=103.60.180.187/30 comment="Mesin Absen" disabled=yes interface=\
    ether4-LAN network=103.60.180.184
add address=192.168.11.1/24 interface=vlanAdmin network=192.168.11.0
add address=192.168.22.1/24 interface=vlanStaff network=192.168.22.0
add address=192.168.33.1/24 interface=vlanStudent network=192.168.33.0
add address=192.168.44.1/24 interface=vlanLecturer network=192.168.44.0
/ip dhcp-server config
set store-leases-disk=immediately
/ip dhcp-server network
add address=192.168.3.0/24 dns-server=8.8.8.8,119.18.156.10,119.18.152.10 \
    gateway=192.168.3.1
add address=192.168.11.0/24 dns-server=8.8.8.8,8.8.4.4 gateway=192.168.11.1
add address=192.168.22.0/24 dns-server=8.8.8.8,8.8.4.4 gateway=192.168.22.1
add address=192.168.33.0/24 dns-server=8.8.8.8,8.8.4.4 gateway=192.168.33.1
add address=192.168.44.0/24 dns-server=8.8.8.8,8.8.4.4 gateway=192.168.44.1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,119.18.156.10,119.18.152.10
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat disabled=yes out-interface=ether5-WAN
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.3.0/24
add action=masquerade chain=srcnat out-interface=bridge-WAN
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.3.0/24
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.11.0/24 to-addresses=0.0.0.0
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.22.0/24 to-addresses=0.0.0.0
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.33.0/24 to-addresses=0.0.0.0
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.44.0/24 to-addresses=0.0.0.0
/ip hotspot ip-binding
add comment=Admin mac-address=C0:3F:D5:53:14:F7 type=bypassed
add comment=Adhom mac-address=14:DD:A9:5B:D8:64 type=bypassed
/ip hotspot user
add comment="counters and limits for trial users" name=default-trial
add name=admin password=ei2684
add name=mhs1 password=mhs123 profile=Others server=hs-vlanStaff
add name=yodi password=yodieys94 profile=Staff server=hs-vlanStaff
add name=ilyas password=ilyas784 profile=Staff server=hs-vlanStaff
add name=rusdi password=rusdi253 profile=Pimpinan
add comment="Hasan Ishak" name=hasan password=ishak profile=Pimpinan
add name=mimin password=mimin748 profile=Staff server=hs-vlanStaff
add name=ikka password=ikka395 profile=Staff server=hs-vlanStaff
add name=derry password=derry942 profile=Staff server=hs-vlanStaff
add comment="Afif Zaerofi" name=afif password=afif468 profile=Pimpinan \
    server=hs-vlanStaff
add name=joko password=joko205 profile=Staff server=hs-vlanStaff
add name=sule password=sule853 profile=Staff server=hs-vlanStaff
add name=nabil password=nabil953 profile=Mahasiswa server=hs-vlanStudent
add name=pardiman password=pardiman372 profile=Staff server=hs-vlanStaff
add name=madlino password=madlino564 profile=Mahasiswa server=hs-vlanStudent
add name=Addieny password=Addieny863 profile=Mahasiswa server=hs-vlanStudent
add name=muhlas password=muhlas739 profile=Others server=hs-vlanStaff
add name=atang password=atang523 profile=Others server=hs-vlanStaff
add name=juragan password=ei2684
add name=sri password=sri734 profile=Pembina server=hs-vlanStaff
add name=rajab password=rajab382 profile=Pembina server=hs-vlanStaff
add name=irwan password=irwan583 profile=Others server=hs-vlanStaff
add name=happy password=happy842 profile=Dosen server=hs-vlanLecturer
add name=didi password=didi932 profile=Others server=hs-vlanStaff
add name=sani password=sani482 profile=Pembina server=hs-vlanStaff
add name=kemal password=kemal931 profile=Staff server=hs-vlanStaff
add name=hamid2 password=hamid734 profile=Pembina server=hs-vlanStaff
add name=Wafi password=Wafi591 profile=Mahasiswa server=hs-vlanStudent
add name=amughni password=amughni294 profile=Dosen server=hs-vlanLecturer
add name=syaichu password=syaichu302 profile=Dosen server=hs-vlanLecturer
add name=afadli password=afadli157 profile=Dosen server=hs-vlanLecturer
add name=asnanp password=asnanp904 profile=Dosen server=hs-vlanLecturer
add name=bohri password=bohri574 profile=Dosen server=hs-vlanLecturer
add name=dewif password=dewif932 profile=Dosen server=hs-vlanLecturer
add name=dodiy password=dodiy589 profile=Dosen server=hs-vlanLecturer
add name=amisno password=amisno158 profile=Dosen server=hs-vlanLecturer
add name=arifrahman password=arifrahman538 profile=Dosen server=\
    hs-vlanLecturer
add name=indra2 password=indra2795 profile=Dosen server=hs-vlanLecturer
add name=laela password=laela112 profile=Dosen server=hs-vlanLecturer
add name=echandra password=echandra749 profile=Dosen server=hs-vlanLecturer
add name=endiana password=endiana625 profile=Dosen server=hs-vlanLecturer
add name=eppy password=eppy980 profile=Dosen server=hs-vlanLecturer
add name=grandis password=grandis347 profile=Dosen server=hs-vlanLecturer
add name=harliani password=harliani213 profile=Dosen server=hs-vlanLecturer
add name=hera2 password=hera2647 profile=Dosen server=hs-vlanLecturer
add name=iris password=iris247 profile=Dosen server=hs-vlanLecturer
add name=irospita password=irospita854 profile=Dosen server=hs-vlanLecturer
add name=khairunisa password=khairunisa483 profile=Dosen server=\
    hs-vlanLecturer
add name=surur password=surur682 profile=Dosen server=hs-vlanLecturer
add name=isa32 password=isa3256 profile=Dosen server=hs-vlanLecturer
add name=muah password=muah4945 profile=Dosen server=hs-vlanLecturer
add name=nasher2 password=nasher2295 profile=Dosen server=hs-vlanLecturer
add name=sopyanm password=sopyanm534 profile=Dosen server=hs-vlanLecturer
add name=shadi password=shadi935 profile=Dosen server=hs-vlanLecturer
add name=ufauzi password=ufauzi000 profile=Dosen server=hs-vlanLecturer
add name=wisnu password=wisnu856 profile=Dosen server=hs-vlanLecturer
add name=akbar password=akbar394 profile=Pembina server=hs-vlanStaff
add name=diva password=diva839 profile=Pembina server=hs-vlanStaff
add name=adita password=adita467 profile=Pembina server=hs-vlanStaff
add name=aya password=aya384 profile=Pembina server=hs-vlanStaff
add name=ammar password=ammar849 profile=Pembina server=hs-vlanStaff
add name=rizky password=rizky394 profile=Pembina server=hs-vlanStaff
add name=andi2 password=andi248 profile=Others server=hs-vlanStaff
add name=wahyudi2 password=wahyudi239 profile=Others server=hs-vlanStaff
add name=anwar2 password=anwar295 profile=Pembina server=hs-vlanStaff
add name=syairul password=syairul643 profile=Dosen server=hs-vlanLecturer
add name=sunarya password=sunarya466 profile=Dosen server=hs-vlanLecturer
add name=joni password=joni495 profile=Dosen server=hs-vlanLecturer
add name=rizaludin password=rizaludin126 profile=Dosen server=hs-vlanLecturer
add name=hanik password=hanik684 profile=Dosen server=hs-vlanLecturer
add name=hendi2 password=hendi245 profile=Others server=hs-vlanStaff
add name=syahrul2 password=syahrul203 profile=Others server=hs-vlanStaff
add name=mhsatas password=mhsatas123 profile="Mahasiswa Atas" server=\
    hs-vlanStudent
add name=oki password=oki523 profile=Staff server=hs-vlanStaff
add name=m.isa password=isa222 profile=Dosen server=hs-vlanLecturer
add disabled=yes name=ahmad23 password=ahmad237 server=hotspotLAN
add name=nano password=nano452 profile=Others server=hs-vlanStaff
add name=wildan1 password=wildan246 profile=Others server=hs-vlanStaff
add name=rafly1 password=mumu99 profile=Others server=hs-vlanStaff
add name=berry password=berry profile=Others server=hs-vlanStaff
add name=amal password=amal123 profile=Others server=hs-vlanStaff
add comment="Khusus Anak Magang" name=magang password=magang123 profile=\
    magang server=hs-vlanStudent
add comment="Staf Tazkia" name=staf password=staftazkia123 profile=staf-15 \
    server=hotspotLAN
add comment="Khusus Tamu" name=tamu password=tamu123 profile=Others server=\
    hs-vlanStudent
add name=dwi password=dwi486 profile=Mahasiswa server=hs-vlanStudent
add name=azizah password=azizah222 profile=Mahasiswa server=hs-vlanStudent
add name=khodijah password=kohdijah452 profile=Mahasiswa server=\
    hs-vlanStudent
add name=rahmi password=rahmi753 profile=Mahasiswa server=hs-vlanStudent
add name=sophia password=sophia845 profile=Mahasiswa server=hs-vlanStudent
add name=nurul password=nurul152 profile=Mahasiswa server=hs-vlanStudent
add name=eleina password=eleina258 profile=Mahasiswa server=hs-vlanStudent
add name=annisa password=annisa754 profile=Mahasiswa server=hs-vlanStudent
add name=aisyah password=aisyah147 profile=Mahasiswa server=hs-vlanStudent
add name=maharani password=maharani487 profile=Mahasiswa server=\
    hs-vlanStudent
add name=delvia password=delvia714 profile=Mahasiswa server=hs-vlanStudent
add name=hariri password=hariri354 profile=Mahasiswa server=hs-vlanStudent
add name=anjariani password=anjariani264 profile=Mahasiswa server=\
    hs-vlanStudent
add name=novia password=novia861 profile=Mahasiswa server=hs-vlanStudent
add name=dina password=dina601 profile=Mahasiswa server=hs-vlanStudent
add name=intan password=intan425 profile=Mahasiswa server=hs-vlanStudent
add name=wahyudi password=wahyudi746 profile=Mahasiswa server=hs-vlanStudent
add name=agung password=agung157 profile=Mahasiswa server=hs-vlanStudent
add name=maulana password=maulana482 profile=Mahasiswa server=hs-vlanStudent
add name=bayu password=bayu705 profile=Mahasiswa server=hs-vlanStudent
add name=raditya password=raditya785 profile=Mahasiswa server=hs-vlanStudent
add name=hafiz password=hafiz516 profile=Mahasiswa server=hs-vlanStudent
add name=irfan password=irfan164 profile=Mahasiswa server=hs-vlanStudent
add name=restu password=restu712 profile=Mahasiswa server=hs-vlanStudent
add name=iqbal password=iqbal147 profile=Mahasiswa server=hs-vlanStudent
add name=luthfi password=luthfi249 profile=Mahasiswa server=hs-vlanStudent
add name=zein password=zein784 profile=Mahasiswa server=hs-vlanStudent
add name=habib password=habib792 profile=Mahasiswa server=hs-vlanStudent
add name=alwi password=alwi543 profile=Mahasiswa server=hs-vlanStudent
add name=radityo password=radityo721 profile=Mahasiswa server=hs-vlanStudent
add name=hamdi password=hamdi137 profile=Mahasiswa server=hs-vlanStudent
add name=ghifari password=ghifari731 profile=Mahasiswa server=hs-vlanStudent
add name=thufei password=thufei346 profile=Mahasiswa server=hs-vlanStudent
add name=raffi password=raffi164 profile=Mahasiswa server=hs-vlanStudent
add name=robbani password=robbani584 profile=Mahasiswa server=hs-vlanStudent
add name="ariq " password=ariq249 profile=Mahasiswa server=hs-vlanStudent
add name=ehza password=ehza685 profile=Mahasiswa server=hs-vlanStudent
add name=bahrudin password=bahrudin629 profile=Mahasiswa server=\
    hs-vlanStudent
add name=afandi password=afandi486 profile=Mahasiswa server=hs-vlanStudent
add name=komarudin password=komarudin246 profile=Mahasiswa server=\
    hs-vlanStudent
add name=aris password=aris345 profile=Mahasiswa server=hs-vlanStudent
add name=wiratama password=wiratama681 profile=Mahasiswa server=\
    hs-vlanStudent
add name=farid password=farid638 profile=Mahasiswa server=hs-vlanStudent
add name=fadhil password=fadhil846 profile=Mahasiswa server=hs-vlanStudent
add name=rahman password=rahman851 profile=Mahasiswa server=hs-vlanStudent
add name=syami password=syami854 profile=Mahasiswa server=hs-vlanStudent
add name=ilham password=ilham164 profile=Mahasiswa server=hs-vlanStudent
add name=fardhan password=fardhan423 profile=Mahasiswa server=hs-vlanStudent
add name=idris password=idris754 profile=Mahasiswa server=hs-vlanStudent
add name=hananul password=hananul586 profile=Mahasiswa server=hs-vlanStudent
add name=saeful password=saeful854 profile=Mahasiswa server=hs-vlanStudent
add name=aldei password=aldei742 profile=Mahasiswa server=hs-vlanStudent
add name=haikal password=haikal256 profile=Mahasiswa server=hs-vlanStudent
add name=ghafarullah password=ghafarullah682 profile=Mahasiswa server=\
    hs-vlanStudent
add name=adlan password=adlan964 profile=Mahasiswa server=hs-vlanStudent
add name=abdullah password=abdullah862 profile=Mahasiswa server=\
    hs-vlanStudent
add name="iqbal z" password=iqbalz785 profile=Mahasiswa server=hs-vlanStudent
add name=ahmad password=ahmad458 profile=Mahasiswa server=hs-vlanStudent
add name=javier password=javier564 profile=Mahasiswa server=hs-vlanStudent
add name=azmie password=azmie349 profile=Mahasiswa server=hs-vlanStudent
add name=febby password=febby956 profile=Mahasiswa server=hs-vlanStudent
add name=faqih password=faqih153 profile=Mahasiswa server=hs-vlanStudent
add name=musyaffa password=musyaffa624 profile=Mahasiswa server=\
    hs-vlanStudent
add name=farhan password=farhan109 profile=Mahasiswa server=hs-vlanStudent
add name=aprian password=aprian741 profile=Mahasiswa server=hs-vlanStudent
add name=roby password=roby582 profile=Mahasiswa server=hs-vlanStudent
add name=anwar password=anwar194 profile=Mahasiswa server=hs-vlanStudent
add name=shiddiqi password=shiddiqi527 profile=Mahasiswa server=\
    hs-vlanStudent
add name=alvin password=alvin864 profile=Mahasiswa server=hs-vlanStudent
add name=yahya password=yahya298 profile=Mahasiswa server=hs-vlanStudent
add name=dedra password=dedra253 profile=Mahasiswa server=hs-vlanStudent
add name=suhardi password=suhardi429 profile=Mahasiswa server=hs-vlanStudent
add name=ihsan password=ihsan806 profile=Mahasiswa server=hs-vlanStudent
add name=salman password=salman241 profile=Mahasiswa server=hs-vlanStudent
add name=taufik password=taufik485 profile=Mahasiswa server=hs-vlanStudent
add name=paiz password=paiz348 profile=Mahasiswa server=hs-vlanStudent
add name=rifki password=rifki437 profile=Mahasiswa server=hs-vlanStudent
add name=taqiyya password=taqiyya614 profile=Mahasiswa server=hs-vlanStudent
add name=waqi password=waqi796 profile=Mahasiswa server=hs-vlanStudent
add name=fakhri password=fakhari209 profile=Mahasiswa server=hs-vlanStudent
add name=fahmi password=fahmi214 profile=Mahasiswa server=hs-vlanStudent
add name=Hamzah password=Hamzah843 profile=Mahasiswa server=hs-vlanStudent
add name=Syahdi password=Syahdi173 profile=Mahasiswa server=hs-vlanStudent
add name=Mardani password=Mardani504 profile=Mahasiswa server=hs-vlanStudent
add name=Aslam password=Aslam617 profile=Mahasiswa server=hs-vlanStudent
add name=Nadia password=Nadia342 profile=Mahasiswa server=hs-vlanStudent
add name=Laila password=Laila453 profile=Mahasiswa server=hs-vlanStudent
add name=Aghna password=Aghna416 profile=Mahasiswa server=hs-vlanStudent
add name=Aini password=Aini349 profile=Mahasiswa server=hs-vlanStudent
add name=Ria password=Ria846 profile=Mahasiswa server=hs-vlanStudent
add name=Ghea password=Ghea946 profile=Mahasiswa server=hs-vlanStudent
add name=Mona password=Mona876 profile=Mahasiswa server=hs-vlanStudent
add name=Koriatin password=Koriatin741 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Fiskasari password=Fiskasari954 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Hilyatil password=Hilyatil751 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Zahra password=Zahra368 profile=Mahasiswa server=hs-vlanStudent
add name=Farras password=Farras359 profile=Mahasiswa server=hs-vlanStudent
add name=Aliyah password=Aliyah584 profile=Mahasiswa server=hs-vlanStudent
add name=Afifah password=Afifah357 profile=Mahasiswa server=hs-vlanStudent
add name=Madania password=Madania153 profile=Mahasiswa server=hs-vlanStudent
add name=Junata password=Junata495 profile=Mahasiswa server=hs-vlanStudent
add name=Saidah password=Saidah682 profile=Mahasiswa server=hs-vlanStudent
add name=Mulfaizah password=Mulfaizah469 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Nabilah password=Nabilah785 profile=Mahasiswa server=hs-vlanStudent
add name=Aulia password=Aulia349 profile=Mahasiswa server=hs-vlanStudent
add name=Alfiani password=Alfiani498 profile=Mahasiswa server=hs-vlanStudent
add name=Rizkia password=Rizkia347 profile=Mahasiswa server=hs-vlanStudent
add name=Salma password=Salma761 profile=Mahasiswa server=hs-vlanStudent
add name=Hanifah password=Hanifah735 profile=Mahasiswa server=hs-vlanStudent
add name=Mutia password=Mutia157 profile=Mahasiswa server=hs-vlanStudent
add name=Fathi password=Fathi825 profile=Mahasiswa server=hs-vlanStudent
add name=Ayudia password=Ayudia941 profile=Mahasiswa server=hs-vlanStudent
add name=Robbani password=Robbani852 profile=Mahasiswa server=hs-vlanStudent
add name=Widya password=Widya485 profile=Mahasiswa server=hs-vlanStudent
add name=Sakinah password=Sakinah196 profile=Mahasiswa server=hs-vlanStudent
add name=Syiffa password=Syiffa579 profile=Mahasiswa server=hs-vlanStudent
add name=Azkia password=Azkia795 profile=Mahasiswa server=hs-vlanStudent
add name=Adellia password=Adellia349 profile=Mahasiswa server=hs-vlanStudent
add name=Zahidah password=Zahidah864 profile=Mahasiswa server=hs-vlanStudent
add name=Eisha password=Eisha654 profile=Mahasiswa server=hs-vlanStudent
add name=Fadillah password=Fadillah794 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Sekar password=Sekar643 profile=Mahasiswa server=hs-vlanStudent
add name=Rima password=Rima573 profile=Mahasiswa server=hs-vlanStudent
add name=Soraya password=Soraya539 profile=Mahasiswa server=hs-vlanStudent
add name=Putri password=Putri849 profile=Mahasiswa server=hs-vlanStudent
add name=Pratidina password=Pratidina846 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Riski password=Riski842 profile=Mahasiswa server=hs-vlanStudent
add name=Zalika password=Zalika561 profile=Mahasiswa server=hs-vlanStudent
add name=Miranti password=Miranti profile=Mahasiswa server=hs-vlanStudent
add name=Pakarti password=Pakarti795 profile=Mahasiswa server=hs-vlanStudent
add name=Fadhillah password=Fadhillah754 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Febriani password=Febriani954 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Fauziah password=Fauziah854 profile=Mahasiswa server=hs-vlanStudent
add name=Darwiwing password=Darwiwing246 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Yustifa password=Yustifa486 profile=Mahasiswa server=hs-vlanStudent
add name=Wahyu password=wahyu958 profile=Mahasiswa server=hs-vlanStudent
add name=tariq password=tariq294 profile=Mahasiswa server=hs-vlanStudent
add name=Khairu password=Khairu594 profile=Mahasiswa server=hs-vlanStudent
add name=Medina password=Medina298 profile=Mahasiswa server=hs-vlanStudent
add name=Khonsa password=khonsa123 profile=Mahasiswa server=hs-vlanStudent
add name=Alfaizi password=Alfaizi261 profile=Mahasiswa server=hs-vlanStudent
add name=Vindi password=Vindi236 profile=Mahasiswa server=hs-vlanStudent
add name=Brenda password=Brenda128 profile=Mahasiswa server=hs-vlanStudent
add name=Bagus password=Bagus238 profile=Mahasiswa server=hs-vlanStudent
add name=Aliefiyani password=Aliefiyani158 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Sayyidah password=Sayyidah291 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Alfafa password=Alfafa861 profile=Mahasiswa server=hs-vlanStudent
add name=Emonika password=Emonika584 profile=Mahasiswa server=hs-vlanStudent
add name=Uttami password=Uttami736 profile=Mahasiswa server=hs-vlanStudent
add name=Hanun password=Hanun729 profile=Mahasiswa server=hs-vlanStudent
add name=Furaizha password=Furaizha647 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Indah password=Indah592 profile=Mahasiswa server=hs-vlanStudent
add name=Aristi password=Aristi829 profile=Mahasiswa server=hs-vlanStudent
add name=Rahmawati password=Rahmawati527 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Fanny password=Fanny953 profile=Mahasiswa server=hs-vlanStudent
add name=Tamimi password=Tamimi319 profile=Mahasiswa server=hs-vlanStudent
add name=Adela password=Adela693 profile=Mahasiswa server=hs-vlanStudent
add name=Nabil password=Nabil846 profile=Mahasiswa server=hs-vlanStudent
add name=Suherlan password=Suherlan248 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Fauzan password=Fauzan368 profile=Mahasiswa server=hs-vlanStudent
add name=Tegar password=Tegar794 profile=Mahasiswa server=hs-vlanStudent
add name=Iftikhor password=Iftikhor542 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Ainal password=Ainal394 profile=Mahasiswa server=hs-vlanStudent
add name=Alfauzan password=Alfauzan258 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Annisatul password=Annisatul274 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Krisna password=Krisna240 profile=Mahasiswa server=hs-vlanStudent
add name=syahfrul password="Syahrul 846" profile=Mahasiswa server=\
    hs-vlanStudent
add name=Farrastyo password=Farrastyo864 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Reinaldi password=Reinaldi642 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Muzakki password=Muzakki208 profile=Mahasiswa server=hs-vlanStudent
add name=nur password=nur793 profile=Mahasiswa server=hs-vlanStudent
add name=Ivan password=Ivan784 profile=Mahasiswa server=hs-vlanStudent
add name=Aunul password=Aunul792 profile=Mahasiswa server=hs-vlanStudent
add name=Ardika password=Ardika275 profile=Mahasiswa server=hs-vlanStudent
add name=Shiddiq password=Shiddiq931 profile=Mahasiswa server=hs-vlanStudent
add name=Muqtadir password=Muqtadir528 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Edwin password=Edwin851 profile=Mahasiswa server=hs-vlanStudent
add name=Bramantyo password=Bramantyo861 profile=Mahasiswa server=\
    hs-vlanStudent
add name=naufal password=naufal975 profile=Mahasiswa server=hs-vlanStudent
add name=Khatami password=khatami294 profile=Mahasiswa server=hs-vlanStudent
add name=M.Fauzan password=M.Fauzan951 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Akbar password=Akbar958 profile=Mahasiswa server=hs-vlanStudent
add name=Zikrul password=Zikrul749 profile=Mahasiswa server=hs-vlanStudent
add name=Fadhil password=Fadhil594 profile=Mahasiswa server=hs-vlanStudent
add name=Fadhilah password=Fadhilah284 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Nadiyah password=Nadiyah475 profile=Mahasiswa server=hs-vlanStudent
add name=Tarini password=Tarini652 profile=Mahasiswa server=hs-vlanStudent
add name=andi password=andi264 profile=Mahasiswa server=hs-vlanStudent
add name=Ireta password=Ireta849 profile=Mahasiswa server=hs-vlanStudent
add name=Humairah password=humairah746 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Anggianisah password=Anggianisah946 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Khair password=Khair841 profile=Mahasiswa server=hs-vlanStudent
add name=Amalia password=Amalia235 profile=Mahasiswa server=hs-vlanStudent
add name=Kurniawati password=Kurniawati239 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Rahil password=Rahil253 profile=Mahasiswa server=hs-vlanStudent
add name=Astikah password=Astikah853 profile=Mahasiswa server=hs-vlanStudent
add name=Syafira password=Syafira085 profile=Mahasiswa server=hs-vlanStudent
add name=Karimah password=Karimah790 profile=Mahasiswa server=hs-vlanStudent
add name=Siti password=Siti420 profile=Mahasiswa server=hs-vlanStudent
add name=Shalihah password=Shalihah294 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Fahimah password=Fahimah846 profile=Mahasiswa server=hs-vlanStudent
add name=Faya password=Faya462 profile=Mahasiswa server=hs-vlanStudent
add name=Hayati password=Hayati493 profile=Mahasiswa server=hs-vlanStudent
add name=Khasanah password=Khasanah564 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Arsha password=Arsha236 profile=Mahasiswa server=hs-vlanStudent
add name=Novalina password=Novalina872 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Dara password=dara284 profile=Mahasiswa server=hs-vlanStudent
add name=Zhafirah password=Zhafirah584 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Agustin password=Agustin846 profile=Mahasiswa server=hs-vlanStudent
add name=Balqia password=Balqia480 profile=Mahasiswa server=hs-vlanStudent
add name=Azzahrah password=Azzahrah510 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Kartikasari password=Kartikasari946 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Dani password=Dani750 profile=Mahasiswa server=hs-vlanStudent
add name=Thufailmubarak password=Thufailmubarak820 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Atiqah password=Atiqah561 profile=Mahasiswa server=hs-vlanStudent
add name=Tsuraya password=Tsuraya749 profile=Mahasiswa server=hs-vlanStudent
add name=Nurhawary password=Nurhawary854 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Afif password=Afif708 profile=Mahasiswa server=hs-vlanStudent
add name=Robiatul password=Robiatul975 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Yumna password=Yumna749 profile=Mahasiswa server=hs-vlanStudent
add name=Wadi password=Wadi153 profile=Mahasiswa server=hs-vlanStudent
add name=Alifia password=Alifia830 profile=Mahasiswa server=hs-vlanStudent
add name=Ayussnita password=Ayussnita749 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Rohmayanti password=Rohmayanti409 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Annisa password=Annisa579 profile=Mahasiswa server=hs-vlanStudent
add name=Agung password=Agung943 profile=Mahasiswa server=hs-vlanStudent
add name=Qodri password=Qodri395 profile=Mahasiswa server=hs-vlanStudent
add name=Zacky password=Zacky593 profile=Mahasiswa server=hs-vlanStudent
add name=Bilal password=Bilal756 profile=Mahasiswa server=hs-vlanStudent
add name=Najjmurrahman password=Najjmurrahman591 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Sobriyana password=Sobriyana497 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Misluha password=Misluha185 profile=Mahasiswa server=hs-vlanStudent
add name=Wijaya password=Wijaya759 profile=Mahasiswa server=hs-vlanStudent
add name=Yusuf password=Yusuf830 profile=Mahasiswa server=hs-vlanStudent
add name=Haris password=Haris076 profile=Mahasiswa server=hs-vlanStudent
add name=Hanafi password=Hanafi853 profile=Mahasiswa server=hs-vlanStudent
add name=Satria password=Satria648 profile=Mahasiswa server=hs-vlanStudent
add name=Rasvi password=Rasvi839 profile=Mahasiswa server=hs-vlanStudent
add name=hafidzakbar password=hafidzakbar738 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Asyraf password=Asyraf249 profile=Mahasiswa server=hs-vlanStudent
add name=Athif password=Athif915 profile=Mahasiswa server=hs-vlanStudent
add name=Gunawan password=Gunawan830 profile=Mahasiswa server=hs-vlanStudent
add name=Mulki password=Mulki305 profile=Mahasiswa server=hs-vlanStudent
add name=Danti password=Danti807 profile=Mahasiswa server=hs-vlanStudent
add name=Munira password=Munira834 profile=Mahasiswa server=hs-vlanStudent
add name=Herdayanti password=Herdayanti964 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Fikriani password=Fikriani946 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Nurhuda password=Nurhuda738 profile=Mahasiswa server=hs-vlanStudent
add name=salsabila password=salsabila294 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Sarah password=Sarah529 profile=Mahasiswa server=hs-vlanStudent
add name=Naufal password=Naufal924 profile=Mahasiswa server=hs-vlanStudent
add name=Fikar password=Fikar482 profile=Mahasiswa server=hs-vlanStudent
add name=Lazuardi password=Lazuardi431 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Nada password=Nada319 profile=Mahasiswa server=hs-vlanStudent
add name=Sahara password=Sahara249 profile=Mahasiswa server=hs-vlanStudent
add name=Nurmalia password=Nurmalia253 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Atikah password=Atikah240 profile=Mahasiswa server=hs-vlanStudent
add name=Kamalasari password=Kamalasari482 profile=Mahasiswa server=\
    hs-vlanStudent
add name=Rizal password=Rizal471 profile=Mahasiswa server=hs-vlanStudent
add comment="Adi Mulya Suprayogi" name=yogi password=suprayogi
/ip route
add check-gateway=ping distance=1 gateway=103.60.180.185
/system clock
set time-zone-name=Asia/Jakarta
/system identity
set name="CPE-TAZKIA DRAMAGA"
/system routerboard settings
set protected-routerboot=disabled
/system scheduler
add interval=1d name=schedule1 on-event="system reboot" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive start-date=\
    apr/13/2017 start-time=07:30:00
add interval=1d name=schedule2 on-event="system reboot" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive start-date=\
    apr/13/2017 start-time=12:15:00
add interval=1d name=schedule3 on-event="system reboot" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive start-date=\
    apr/13/2017 start-time=16:00:00
/tool romon port
add
