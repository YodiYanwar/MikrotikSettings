/ip hotspot user profile
set [ find default=yes ] rate-limit=15360k/15360k shared-users=1
add idle-timeout=20m keepalive-timeout=5m name=Mahasiswa rate-limit=400k/350k \
    session-timeout=8h transparent-proxy=yes
add idle-timeout=20m name=Staff rate-limit=512k/400k session-timeout=8h \
    shared-users=2 transparent-proxy=yes
add idle-timeout=20m name=Pembina rate-limit=512k/400k session-timeout=8h \
    transparent-proxy=yes
add idle-timeout=20m name=Pimpinan rate-limit=650k/650k session-timeout=8h \
    shared-users=2 transparent-proxy=yes
add idle-timeout=2m name=Dosen rate-limit=512k/400k session-timeout=8h \
    shared-users=2 transparent-proxy=yes
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