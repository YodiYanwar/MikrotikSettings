# may/18/2017 16:12:10 by RouterOS 6.34.2
# software id = QSRB-M7II
#
/ip hotspot user profile
add address-pool=dhcp_pool1 name=Mahasiswa rate-limit=500k/500k \
    transparent-proxy=yes
/ip hotspot user
add name=test password=test123 server=hotspotLAN
add name=dinda password=123 profile=Mahasiswa server=hotspotLAN
