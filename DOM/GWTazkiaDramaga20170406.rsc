# apr/06/2017 11:13:15 by RouterOS 6.38.5
# software id = CX2R-G22Q
#
/interface bridge
add comment="Jaringan LAN" name=bridge-LAN
add name=bridge-WAN
/interface ethernet
set [ find default-name=ether1 ] name=ether1-LAN
set [ find default-name=ether2 ] name=ether2-ABSEN
set [ find default-name=ether3 ] name=ether3-LAN
set [ find default-name=ether4 ] name=ether4-LAN
set [ find default-name=ether5 ] name=ether5-WAN
/ip hotspot profile
set [ find default=yes ] dns-name=hotspot.matrikulasi.id hotspot-address=\
    192.168.3.1 html-directory=flash/hotspot
add hotspot-address=192.168.3.1 name=hsprof1
/ip hotspot user profile
set [ find default=yes ] rate-limit=15360k/15360k shared-users=2
add idle-timeout=2m keepalive-timeout=5m name=Mahasiswa rate-limit=400k/350k \
    session-timeout=10m transparent-proxy=yes
add idle-timeout=5m name=Staff rate-limit=512k/400k session-timeout=8h \
    transparent-proxy=yes
add idle-timeout=5m name=Pembina rate-limit=512k/400k session-timeout=5h \
    transparent-proxy=yes
add idle-timeout=5m name=Pimpinan rate-limit=650k/650k session-timeout=8h \
    shared-users=2 transparent-proxy=yes
add idle-timeout=2m name=Dosen rate-limit=512k/400k session-timeout=8h \
    transparent-proxy=yes
add idle-timeout=5m name=Others rate-limit=150k/128k session-timeout=5h \
    transparent-proxy=yes
add idle-timeout=1h name=guest rate-limit=512k/512k session-timeout=1h \
    shared-users=5 transparent-proxy=yes
add idle-timeout=2m name="Mahasiswa Atas" rate-limit=350k/250k \
    session-timeout=3h shared-users=20 transparent-proxy=yes
add name=magang rate-limit=384k shared-users=10 transparent-proxy=yes
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=aes-128-cbc
/ip pool
add name=dhcp_pool2 ranges=192.168.3.2-192.168.3.254
add name=dhcp_pool1 ranges=192.168.3.101-192.168.3.200
/ip dhcp-server
add address-pool=dhcp_pool2 interface=ether3-LAN name=dhcp1
add address-pool=dhcp_pool1 disabled=no interface=bridge-LAN name=dhcp2
/ip hotspot
add address-pool=dhcp_pool1 disabled=no interface=bridge-LAN name=hotspot1 \
    profile=hsprof1
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
/ip dhcp-server config
set store-leases-disk=immediately
/ip dhcp-server network
add address=192.168.3.0/24 dns-server=8.8.8.8,119.18.156.10,119.18.152.10 \
    gateway=192.168.3.1
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
/ip hotspot ip-binding
add comment=Admin mac-address=C0:3F:D5:53:14:F7 type=bypassed
add comment=Adhom mac-address=14:DD:A9:5B:D8:64 type=bypassed
/ip hotspot user
add name=admin password=ei2684 server=hotspot1
add name=mhs1 password=mhs123 profile=Others server=hotspot1
add name=yodi password=yodieys94 profile=Staff server=hotspot1
add name=ilyas password=ilyas784 profile=Staff server=hotspot1
add name=siti password=siti637 profile=Staff server=hotspot1
add name=neng password=neng910 profile=Staff server=hotspot1
add name=rusdi password=rusdi253 profile=Pimpinan server=hotspot1
add name=hasan password=hasan846 profile=Pimpinan server=hotspot1
add name=mimin password=mimin748 profile=Staff server=hotspot1
add name=ikka password=ikka395 profile=Staff server=hotspot1
add name=derry password=derry942 profile=Staff server=hotspot1
add name=afif password=afif468 profile=Pimpinan server=hotspot1
add name=joko password=joko205 profile=Staff server=hotspot1
add name=sule password=sule853 profile=Staff server=hotspot1
add name=nabil password=nabil953 profile=Mahasiswa server=hotspot1
add name=pardiman password=pardiman372 profile=Staff server=hotspot1
add name=dwi password=dwi486 profile=Mahasiswa server=hotspot1
add name=azizah password=azizah222 profile=Mahasiswa server=hotspot1
add name=khodijah password=kohdijah452 profile=Mahasiswa server=hotspot1
add name=rahmi password=rahmi753 profile=Mahasiswa server=hotspot1
add name=sophia password=sophia845 profile=Mahasiswa server=hotspot1
add name=nurul password=nurul152 profile=Mahasiswa server=hotspot1
add name=eleina password=eleina258 profile=Mahasiswa server=hotspot1
add name=annisa password=annisa754 profile=Mahasiswa server=hotspot1
add name=rian password=rian983 profile=Others server=hotspot1
add name=aisyah password=aisyah147 profile=Mahasiswa server=hotspot1
add name=maharani password=maharani487 profile=Mahasiswa server=hotspot1
add name=delvia password=delvia714 profile=Mahasiswa server=hotspot1
add name=hariri password=hariri354 profile=Mahasiswa server=hotspot1
add name=anjariani password=anjariani264 profile=Mahasiswa server=hotspot1
add name=novia password=novia861 profile=Mahasiswa server=hotspot1
add name=dina password=dina601 profile=Mahasiswa server=hotspot1
add name=intan password=intan425 profile=Mahasiswa server=hotspot1
add name=wahyudi password=wahyudi746 profile=Mahasiswa server=hotspot1
add name=agung password=agung157 profile=Mahasiswa server=hotspot1
add name=maulana password=maulana482 profile=Mahasiswa server=hotspot1
add name=bayu password=bayu705 profile=Mahasiswa server=hotspot1
add name=raditya password=raditya785 profile=Mahasiswa server=hotspot1
add name=hafiz password=hafiz516 profile=Mahasiswa server=hotspot1
add name=irfan password=irfan164 profile=Mahasiswa server=hotspot1
add name=restu password=restu712 profile=Mahasiswa server=hotspot1
add name=iqbal password=iqbal147 profile=Mahasiswa server=hotspot1
add name=luthfi password=luthfi249 profile=Mahasiswa server=hotspot1
add name=zein password=zein784 profile=Mahasiswa server=hotspot1
add name=habib password=habib792 profile=Mahasiswa server=hotspot1
add name=alwi password=alwi543 profile=Mahasiswa server=hotspot1
add name=radityo password=radityo721 profile=Mahasiswa server=hotspot1
add name=hamdi password=hamdi137 profile=Mahasiswa server=hotspot1
add name=ghifari password=ghifari731 profile=Mahasiswa server=hotspot1
add name=ghifariyadi password=ghifariyadi852 profile=Mahasiswa server=\
    hotspot1
add name=thufei password=thufei346 profile=Mahasiswa server=hotspot1
add name=raffi password=raffi164 profile=Mahasiswa server=hotspot1
add name=robbani password=robbani584 profile=Mahasiswa server=hotspot1
add name="ariq " password=ariq249 profile=Mahasiswa server=hotspot1
add name=ehza password=ehza685 profile=Mahasiswa server=hotspot1
add name=bahrudin password=bahrudin629 profile=Mahasiswa server=hotspot1
add name=rafly password=rafly295 profile=Mahasiswa server=hotspot1
add name=afandi password=afandi486 profile=Mahasiswa server=hotspot1
add name=indrawan password=indrawan359 profile=Mahasiswa server=hotspot1
add name=madlino password=madlino564 profile=Mahasiswa server=hotspot1
add name=komarudin password=komarudin246 profile=Mahasiswa server=hotspot1
add name=aris password=aris345 profile=Mahasiswa server=hotspot1
add name=wiratama password=wiratama681 profile=Mahasiswa server=hotspot1
add name=refah password=refah357 profile=Mahasiswa server=hotspot1
add name=farid password=farid638 profile=Mahasiswa server=hotspot1
add name=fadhil password=fadhil846 profile=Mahasiswa server=hotspot1
add name=rahman password=rahman851 profile=Mahasiswa server=hotspot1
add name=syami password=syami854 profile=Mahasiswa server=hotspot1
add name=ilham password=ilham164 profile=Mahasiswa server=hotspot1
add name=fardhan password=fardhan423 profile=Mahasiswa server=hotspot1
add name=idris password=idris754 profile=Mahasiswa server=hotspot1
add name=hananul password=hananul586 profile=Mahasiswa server=hotspot1
add name=saeful password=saeful854 profile=Mahasiswa server=hotspot1
add name=andika password=andika516 profile=Mahasiswa server=hotspot1
add name=aldei password=aldei742 profile=Mahasiswa server=hotspot1
add name=haikal password=haikal256 profile=Mahasiswa server=hotspot1
add name=ghafarullah password=ghafarullah682 profile=Mahasiswa server=\
    hotspot1
add name=adlan password=adlan964 profile=Mahasiswa server=hotspot1
add name=abdullah password=abdullah862 profile=Mahasiswa server=hotspot1
add name=shidqi password=shidqi879 profile=Mahasiswa server=hotspot1
add name="iqbal z" password=iqbalz785 profile=Mahasiswa server=hotspot1
add name=ahmad password=ahmad458 profile=Mahasiswa server=hotspot1
add name=javier password=javier564 profile=Mahasiswa server=hotspot1
add name=azmie password=azmie349 profile=Mahasiswa server=hotspot1
add name=febby password=febby956 profile=Mahasiswa server=hotspot1
add name=faqih password=faqih153 profile=Mahasiswa server=hotspot1
add name=rony password=rony482 profile=Mahasiswa server=hotspot1
add name=musyaffa password=musyaffa624 profile=Mahasiswa server=hotspot1
add name=farhan password=farhan109 profile=Mahasiswa server=hotspot1
add name=aprian password=aprian741 profile=Mahasiswa server=hotspot1
add name=roby password=roby582 profile=Mahasiswa server=hotspot1
add name=anwar password=anwar194 profile=Mahasiswa server=hotspot1
add name=shiddiqi password=shiddiqi527 profile=Mahasiswa server=hotspot1
add name=arip password=arip015 profile=Mahasiswa server=hotspot1
add name=alvin password=alvin864 profile=Mahasiswa server=hotspot1
add name=yahya password=yahya298 profile=Mahasiswa server=hotspot1
add name=dedra password=dedra253 profile=Mahasiswa server=hotspot1
add name=suhardi password=suhardi429 profile=Mahasiswa server=hotspot1
add name=ihsan password=ihsan806 profile=Mahasiswa server=hotspot1
add name=salman password=salman241 profile=Mahasiswa server=hotspot1
add name=taufik password=taufik485 profile=Mahasiswa server=hotspot1
add name=paiz password=paiz348 profile=Mahasiswa server=hotspot1
add name=rifki password=rifki437 profile=Mahasiswa server=hotspot1
add name=taqiyya password=taqiyya614 profile=Mahasiswa server=hotspot1
add name=waqi password=waqi796 profile=Mahasiswa server=hotspot1
add name=fakhri password=fakhari209 profile=Mahasiswa server=hotspot1
add name=fahmi password=fahmi214 profile=Mahasiswa server=hotspot1
add name=Firzanarko password=Firzanarko751 profile=Mahasiswa server=hotspot1
add name=Hamzah password=Hamzah843 profile=Mahasiswa server=hotspot1
add name=Syahdi password=Syahdi173 profile=Mahasiswa server=hotspot1
add name=Mardani password=Mardani504 profile=Mahasiswa server=hotspot1
add name=Syauqi password=Syauqi349 profile=Mahasiswa server=hotspot1
add name=Aslam password=Aslam617 profile=Mahasiswa server=hotspot1
add name=Fathan password=Fathan620 profile=Mahasiswa server=hotspot1
add name=Nadia password=Nadia342 profile=Mahasiswa server=hotspot1
add name=Laila password=Laila453 profile=Mahasiswa server=hotspot1
add name=Aghna password=Aghna416 profile=Mahasiswa server=hotspot1
add name=Aini password=Aini349 profile=Mahasiswa server=hotspot1
add name=Ria password=Ria846 profile=Mahasiswa server=hotspot1
add name=Ghea password=Ghea946 profile=Mahasiswa server=hotspot1
add name=Mona password=Mona876 profile=Mahasiswa server=hotspot1
add name=Koriatin password=Koriatin741 profile=Mahasiswa server=hotspot1
add name=Fiskasari password=Fiskasari954 profile=Mahasiswa server=hotspot1
add name=Hilyatil password=Hilyatil751 profile=Mahasiswa server=hotspot1
add name=Zahra password=Zahra368 profile=Mahasiswa server=hotspot1
add name=Farras password=Farras359 profile=Mahasiswa server=hotspot1
add name=Aliyah password=Aliyah584 profile=Mahasiswa server=hotspot1
add name=Afifah password=Afifah357 profile=Mahasiswa server=hotspot1
add name=Madania password=Madania153 profile=Mahasiswa server=hotspot1
add name=Junata password=Junata495 profile=Mahasiswa server=hotspot1
add name=Saidah password=Saidah682 profile=Mahasiswa server=hotspot1
add name=Mulfaizah password=Mulfaizah469 profile=Mahasiswa server=hotspot1
add name=Nabilah password=Nabilah785 profile=Mahasiswa server=hotspot1
add name=Aulia password=Aulia349 profile=Mahasiswa server=hotspot1
add name=Alfiani password=Alfiani498 profile=Mahasiswa server=hotspot1
add name=Rizkia password=Rizkia347 profile=Mahasiswa server=hotspot1
add name=Salma password=Salma761 profile=Mahasiswa server=hotspot1
add name=Hanifah password=Hanifah735 profile=Mahasiswa server=hotspot1
add name=Mutia password=Mutia157 profile=Mahasiswa server=hotspot1
add name=Fathi password=Fathi825 profile=Mahasiswa server=hotspot1
add name=Ayudia password=Ayudia941 profile=Mahasiswa server=hotspot1
add name=Robbani password=Robbani852 profile=Mahasiswa server=hotspot1
add name=Widya password=Widya485 profile=Mahasiswa server=hotspot1
add name=Sakinah password=Sakinah196 profile=Mahasiswa server=hotspot1
add name=Syiffa password=Syiffa579 profile=Mahasiswa server=hotspot1
add name=Azkia password=Azkia795 profile=Mahasiswa server=hotspot1
add name=Adellia password=Adellia349 profile=Mahasiswa server=hotspot1
add name=Zahidah password=Zahidah864 profile=Mahasiswa server=hotspot1
add name=Eisha password=Eisha654 profile=Mahasiswa server=hotspot1
add name=Fadillah password=Fadillah794 profile=Mahasiswa server=hotspot1
add name=Sekar password=Sekar643 profile=Mahasiswa server=hotspot1
add name=Rima password=Rima573 profile=Mahasiswa server=hotspot1
add name=Soraya password=Soraya539 profile=Mahasiswa server=hotspot1
add name=Putri password=Putri849 profile=Mahasiswa server=hotspot1
add name=Pratidina password=Pratidina846 profile=Mahasiswa server=hotspot1
add name=Riski password=Riski842 profile=Mahasiswa server=hotspot1
add name=Zalika password=Zalika561 profile=Mahasiswa server=hotspot1
add name=Miranti password=Miranti profile=Mahasiswa server=hotspot1
add name=Pakarti password=Pakarti795 profile=Mahasiswa server=hotspot1
add name=Fadhillah password=Fadhillah754 profile=Mahasiswa server=hotspot1
add name=Febriani password=Febriani954 profile=Mahasiswa server=hotspot1
add name=Fauziah password=Fauziah854 profile=Mahasiswa server=hotspot1
add name=Darwiwing password=Darwiwing246 profile=Mahasiswa server=hotspot1
add name=Dicky password=Dicky397 profile=Mahasiswa server=hotspot1
add name=Yustifa password=Yustifa486 profile=Mahasiswa server=hotspot1
add name=Wahyu password=wahyu958 profile=Mahasiswa server=hotspot1
add name=tariq password=tariq294 profile=Mahasiswa server=hotspot1
add name=Khairu password=Khairu594 profile=Mahasiswa server=hotspot1
add name=Medina password=Medina298 profile=Mahasiswa server=hotspot1
add name=Fadilla password=Fadilla684 profile=Mahasiswa server=hotspot1
add name=Khonsa password=khonsa123 profile=Mahasiswa server=hotspot1
add name=Jordi password=Jordi361 profile=Mahasiswa server=hotspot1
add name=Alfaizi password=Alfaizi261 profile=Mahasiswa server=hotspot1
add name=Vindi password=Vindi236 profile=Mahasiswa server=hotspot1
add name=Brenda password=Brenda128 profile=Mahasiswa server=hotspot1
add name=Bagus password=Bagus238 profile=Mahasiswa server=hotspot1
add name=Aliefiyani password=Aliefiyani158 profile=Mahasiswa server=hotspot1
add name=Sayyidah password=Sayyidah291 profile=Mahasiswa server=hotspot1
add name=Alfafa password=Alfafa861 profile=Mahasiswa server=hotspot1
add name=Emonika password=Emonika584 profile=Mahasiswa server=hotspot1
add name=Uttami password=Uttami736 profile=Mahasiswa server=hotspot1
add name=Hanun password=Hanun729 profile=Mahasiswa server=hotspot1
add name=Furaizha password=Furaizha647 profile=Mahasiswa server=hotspot1
add name=Indah password=Indah592 profile=Mahasiswa server=hotspot1
add name=Aristi password=Aristi829 profile=Mahasiswa server=hotspot1
add name=Rahmawati password=Rahmawati527 profile=Mahasiswa server=hotspot1
add name=Fanny password=Fanny953 profile=Mahasiswa server=hotspot1
add name=Tamimi password=Tamimi319 profile=Mahasiswa server=hotspot1
add name=Adela password=Adela693 profile=Mahasiswa server=hotspot1
add name=Nabil password=Nabil846 profile=Mahasiswa server=hotspot1
add name=Suherlan password=Suherlan248 profile=Mahasiswa server=hotspot1
add name=Fauzan password=Fauzan368 profile=Mahasiswa server=hotspot1
add name=Adam password=Adam361 profile=Mahasiswa server=hotspot1
add name=Tegar password=Tegar794 profile=Mahasiswa server=hotspot1
add name=Iftikhor password=Iftikhor542 profile=Mahasiswa server=hotspot1
add name=Muzannif password=Muzannif294 profile=Mahasiswa server=hotspot1
add name=Ainal password=Ainal394 profile=Mahasiswa server=hotspot1
add name=Alfauzan password=Alfauzan258 profile=Mahasiswa server=hotspot1
add name=Annisatul password=Annisatul274 profile=Mahasiswa server=hotspot1
add name=Krisna password=Krisna240 profile=Mahasiswa server=hotspot1
add name=Muhammad password=Muhammad341 profile=Mahasiswa server=hotspot1
add name=syahfrul password="Syahrul 846" profile=Mahasiswa server=hotspot1
add name=Farrastyo password=Farrastyo864 profile=Mahasiswa server=hotspot1
add name=Reinaldi password=Reinaldi642 profile=Mahasiswa server=hotspot1
add name=Kemal password=Kemal485 profile=Mahasiswa server=hotspot1
add name=Muzakki password=Muzakki208 profile=Mahasiswa server=hotspot1
add name=nur password=nur793 profile=Mahasiswa server=hotspot1
add name=Ivan password=Ivan784 profile=Mahasiswa server=hotspot1
add name=Aghniya password=Aghniya259 profile=Mahasiswa server=hotspot1
add name=Aunul password=Aunul792 profile=Mahasiswa server=hotspot1
add name=Ardika password=Ardika275 profile=Mahasiswa server=hotspot1
add name=Shiddiq password=Shiddiq931 profile=Mahasiswa server=hotspot1
add name=Hidayaturrahman password=Hidayaturrahman785 profile=Mahasiswa \
    server=hotspot1
add name=Addieny password=Addieny863 profile=Mahasiswa server=hotspot1
add name=muhlas password=muhlas739 profile=Others server=hotspot1
add name=atang password=atang523 profile=Others server=hotspot1
add name=juragan password=ei2684 server=hotspot1
add name=sri password=sri734 profile=Pembina server=hotspot1
add name=rajab password=rajab382 profile=Pembina server=hotspot1
add name=irwan password=irwan583 profile=Others server=hotspot1
add name=happy password=happy842 profile=Dosen server=hotspot1
add name=ari password=ari942 profile=Pimpinan server=hotspot1
add name=didi password=didi932 profile=Others server=hotspot1
add name=sani password=sani482 profile=Pembina server=hotspot1
add name=kemal password=kemal931 profile=Staff server=hotspot1
add name=hamid2 password=hamid734 profile=Pembina server=hotspot1
add name=Muqtadir password=Muqtadir528 profile=Mahasiswa server=hotspot1
add name=Cahya password=Cahya381 profile=Mahasiswa server=hotspot1
add name=Edwin password=Edwin851 profile=Mahasiswa server=hotspot1
add name=Bramantyo password=Bramantyo861 profile=Mahasiswa server=hotspot1
add name=naufal password=naufal975 profile=Mahasiswa server=hotspot1
add name=Khatami password=khatami294 profile=Mahasiswa server=hotspot1
add name=M.Fauzan password=M.Fauzan951 profile=Mahasiswa server=hotspot1
add name=Akbar password=Akbar958 profile=Mahasiswa server=hotspot1
add name=Zikrul password=Zikrul749 profile=Mahasiswa server=hotspot1
add name=Fadhil password=Fadhil594 profile=Mahasiswa server=hotspot1
add name=Fadhilah password=Fadhilah284 profile=Mahasiswa server=hotspot1
add name=Nadiyah password=Nadiyah475 profile=Mahasiswa server=hotspot1
add name=Tarini password=Tarini652 profile=Mahasiswa server=hotspot1
add name=andi password=andi264 profile=Mahasiswa server=hotspot1
add name=Ireta password=Ireta849 profile=Mahasiswa server=hotspot1
add name=Humairah password=humairah746 profile=Mahasiswa server=hotspot1
add name=Anggianisah password=Anggianisah946 profile=Mahasiswa server=\
    hotspot1
add name=Khair password=Khair841 profile=Mahasiswa server=hotspot1
add name=Amalia password=Amalia235 profile=Mahasiswa server=hotspot1
add name=Kurniawati password=Kurniawati239 profile=Mahasiswa server=hotspot1
add name=Rahil password=Rahil253 profile=Mahasiswa server=hotspot1
add name=Astikah password=Astikah853 profile=Mahasiswa server=hotspot1
add name=Syafira password=Syafira085 profile=Mahasiswa server=hotspot1
add name=Karimah password=Karimah790 profile=Mahasiswa server=hotspot1
add name=Siti password=Siti420 profile=Mahasiswa server=hotspot1
add name=Shalihah password=Shalihah294 profile=Mahasiswa server=hotspot1
add name=Fahimah password=Fahimah846 profile=Mahasiswa server=hotspot1
add name=Faya password=Faya462 profile=Mahasiswa server=hotspot1
add name=Hayati password=Hayati493 profile=Mahasiswa server=hotspot1
add name=Khasanah password=Khasanah564 profile=Mahasiswa server=hotspot1
add name=Arsha password=Arsha236 profile=Mahasiswa server=hotspot1
add name=Novalina password=Novalina872 profile=Mahasiswa server=hotspot1
add name=Dara password=dara284 profile=Mahasiswa server=hotspot1
add name=Zhafirah password=Zhafirah584 profile=Mahasiswa server=hotspot1
add name=Agustin password=Agustin846 profile=Mahasiswa server=hotspot1
add name=Balqia password=Balqia480 profile=Mahasiswa server=hotspot1
add name=Azzahrah password=Azzahrah510 profile=Mahasiswa server=hotspot1
add name=Kartikasari password=Kartikasari946 profile=Mahasiswa server=\
    hotspot1
add name=Dani password=Dani750 profile=Mahasiswa server=hotspot1
add name=Thufailmubarak password=Thufailmubarak820 profile=Mahasiswa server=\
    hotspot1
add name=Atiqah password=Atiqah561 profile=Mahasiswa server=hotspot1
add name=Tsuraya password=Tsuraya749 profile=Mahasiswa server=hotspot1
add name=Khalifa password=Khalifa507 profile=Mahasiswa server=hotspot1
add name=Nurhawary password=Nurhawary854 profile=Mahasiswa server=hotspot1
add name=Afif password=Afif708 profile=Mahasiswa server=hotspot1
add name=Robiatul password=Robiatul975 profile=Mahasiswa server=hotspot1
add name=Yumna password=Yumna749 profile=Mahasiswa server=hotspot1
add name=Wadi password=Wadi153 profile=Mahasiswa server=hotspot1
add name=Alifia password=Alifia830 profile=Mahasiswa server=hotspot1
add name=Ayussnita password=Ayussnita749 profile=Mahasiswa server=hotspot1
add name=Rohmayanti password=Rohmayanti409 profile=Mahasiswa server=hotspot1
add name=Annisa password=Annisa579 profile=Mahasiswa server=hotspot1
add name=Agung password=Agung943 profile=Mahasiswa server=hotspot1
add name=Qodri password=Qodri395 profile=Mahasiswa server=hotspot1
add name=Zacky password=Zacky593 profile=Mahasiswa server=hotspot1
add name=Bilal password=Bilal756 profile=Mahasiswa server=hotspot1
add name=bintang password=bintang849 profile=Pembina server=hotspot1
add name=Najjmurrahman password=Najjmurrahman591 profile=Mahasiswa server=\
    hotspot1
add name=Sobriyana password=Sobriyana497 profile=Mahasiswa server=hotspot1
add name=Misluha password=Misluha185 profile=Mahasiswa server=hotspot1
add name=Wijaya password=Wijaya759 profile=Mahasiswa server=hotspot1
add name=Yusuf password=Yusuf830 profile=Mahasiswa server=hotspot1
add name=Haris password=Haris076 profile=Mahasiswa server=hotspot1
add name=Raihan password=Raihan197 profile=Mahasiswa server=hotspot1
add name=Hanafi password=Hanafi853 profile=Mahasiswa server=hotspot1
add name=Satria password=Satria648 profile=Mahasiswa server=hotspot1
add name=Rasvi password=Rasvi839 profile=Mahasiswa server=hotspot1
add name=Hamdi password=Hamdi862 profile=Mahasiswa server=hotspot1
add name=hafidzakbar password=hafidzakbar738 profile=Mahasiswa server=\
    hotspot1
add name=Asyraf password=Asyraf249 profile=Mahasiswa server=hotspot1
add name=Alfianoor password=Alfianoor753 profile=Mahasiswa server=hotspot1
add name=Wafi password=Wafi591 profile=Mahasiswa server=hotspot1
add name=Athif password=Athif915 profile=Mahasiswa server=hotspot1
add name=Gunawan password=Gunawan830 profile=Mahasiswa server=hotspot1
add name=Mulki password=Mulki305 profile=Mahasiswa server=hotspot1
add name=Danti password=Danti807 profile=Mahasiswa server=hotspot1
add name=Munira password=Munira834 profile=Mahasiswa server=hotspot1
add name=Herdayanti password=Herdayanti964 profile=Mahasiswa server=hotspot1
add name=Fikriani password=Fikriani946 profile=Mahasiswa server=hotspot1
add name=Nurhuda password=Nurhuda738 profile=Mahasiswa server=hotspot1
add name=salsabila password=salsabila294 profile=Mahasiswa server=hotspot1
add name=Sarah password=Sarah529 profile=Mahasiswa server=hotspot1
add name=Naufal password=Naufal924 profile=Mahasiswa server=hotspot1
add name=Fikar password=Fikar482 profile=Mahasiswa server=hotspot1
add name=Lazuardi password=Lazuardi431 profile=Mahasiswa server=hotspot1
add name=Nada password=Nada319 profile=Mahasiswa server=hotspot1
add name=Sahara password=Sahara249 profile=Mahasiswa server=hotspot1
add name=Nurmalia password=Nurmalia253 profile=Mahasiswa server=hotspot1
add name=Atikah password=Atikah240 profile=Mahasiswa server=hotspot1
add name=Kamalasari password=Kamalasari482 profile=Mahasiswa server=hotspot1
add name=Rizal password=Rizal471 profile=Mahasiswa server=hotspot1
add name=amughni password=amughni294 profile=Dosen server=hotspot1
add name=syaichu password=syaichu302 profile=Dosen server=hotspot1
add name=afadli password=afadli157 profile=Dosen server=hotspot1
add name=asnanp password=asnanp904 profile=Dosen server=hotspot1
add name=bohri password=bohri574 profile=Dosen server=hotspot1
add name=dewif password=dewif932 profile=Dosen server=hotspot1
add name=dodiy password=dodiy589 profile=Dosen server=hotspot1
add name=amisno password=amisno158 profile=Dosen server=hotspot1
add name=arifrahman password=arifrahman538 profile=Dosen server=hotspot1
add name=indra2 password=indra2795 profile=Dosen server=hotspot1
add name=laela password=laela112 profile=Dosen server=hotspot1
add name=echandra password=echandra749 profile=Dosen server=hotspot1
add name=endiana password=endiana625 profile=Dosen server=hotspot1
add name=eppy password=eppy980 profile=Dosen server=hotspot1
add name=galih password=galih576 profile=Dosen server=hotspot1
add name=grandis password=grandis347 profile=Dosen server=hotspot1
add name=harliani password=harliani213 profile=Dosen server=hotspot1
add name=hera2 password=hera2647 profile=Dosen server=hotspot1
add name=iris password=iris247 profile=Dosen server=hotspot1
add name=irospita password=irospita854 profile=Dosen server=hotspot1
add name=khairunisa password=khairunisa483 profile=Dosen server=hotspot1
add name=surur password=surur682 profile=Dosen server=hotspot1
add name=isa32 password=isa3256 profile=Dosen server=hotspot1
add name=muah password=muah4945 profile=Dosen server=hotspot1
add name=nasher2 password=nasher2295 profile=Dosen server=hotspot1
add name=sopyanm password=sopyanm534 profile=Dosen server=hotspot1
add name=sulhani password=sulhani753 profile=Dosen server=hotspot1
add name=shadi password=shadi935 profile=Dosen server=hotspot1
add name=ufauzi password=ufauzi000 profile=Dosen server=hotspot1
add name=wisnu password=wisnu856 profile=Dosen server=hotspot1
add name=yaser password=yaser495 profile=Dosen server=hotspot1
add name=akbar password=akbar394 profile=Pembina server=hotspot1
add name=diva password=diva839 profile=Pembina server=hotspot1
add name=adita password=adita467 profile=Pembina server=hotspot1
add name=aya password=aya384 profile=Pembina server=hotspot1
add name=ammar password=ammar849 profile=Pembina server=hotspot1
add name=rizky password=rizky394 profile=Pembina server=hotspot1
add name=andi2 password=andi248 profile=Others server=hotspot1
add name=wahyudi2 password=wahyudi239 profile=Others server=hotspot1
add name=anwar2 password=anwar295 profile=Pembina server=hotspot1
add name=syairul password=syairul643 profile=Dosen server=hotspot1
add name=sunarya password=sunarya466 profile=Dosen server=hotspot1
add name=joni password=joni495 profile=Dosen server=hotspot1
add name=rizaludin password=rizaludin126 profile=Dosen server=hotspot1
add name=hanik password=hanik684 profile=Dosen server=hotspot1
add name=andang password=andang483 profile=Pimpinan server=hotspot1
add name=hendi2 password=hendi245 profile=Others server=hotspot1
add name=syahrul2 password=syahrul203 profile=Others server=hotspot1
add name=tamu password=tamu123 profile=guest server=hotspot1
add name=mhsatas password=mhsatas123 profile="Mahasiswa Atas" server=hotspot1
add name=oki password=oki523 profile=Staff server=hotspot1
add name=m.isa password=isa222 profile=Dosen server=hotspot1
add name=ahmad23 password=ahmad237 server=hotspot1
add name=nano password=nano452 profile=Others server=hotspot1
add name=wildan1 password=wildan246 profile=Others server=hotspot1
add name=rafly1 password=mumu99 profile=Others server=hotspot1
add name=berry password=berry profile=Others server=hotspot1
add name=amal password=amal123 profile=Others server=hotspot1
add comment="Khusus Anak Magang" name=magang password=magang123 profile=\
    magang server=hotspot1
/ip route
add check-gateway=ping distance=1 gateway=103.60.180.185
/system clock
set time-zone-name=Asia/Jakarta
/system identity
set name="CPE-TAZKIA DRAMAGA"
/tool romon port
add
