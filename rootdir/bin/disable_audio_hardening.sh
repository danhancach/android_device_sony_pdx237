#!/system/bin/sh
# Disable A17 background audio hardening (merchant apps: Coupang, Baemin, …).

cmd audio set-hardening disable >/dev/null 2>&1
