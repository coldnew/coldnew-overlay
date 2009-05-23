#!/sbin/runscript
## 2003 by H+BEDV Datentechnik GmbH,
## Wolfram Schlich <wschlich@antivir.de>

svc_name="AntiVir WebGate"

## required binaries
avwebgate_bin="/usr/lib/AntiVir/avwebgate.bin"

## required config files
avwebgate_cfg="/etc/avwebgate.conf"
avwebgate_acl="/etc/avwebgate.acl"

depend() {
	need net
	use logger dns squid
}

checkconfig() {
	if [ ! -x "${avwebgate_bin}" ]; then
		eerror "avwebgate binary [${avwebgate_bin}] missing"
		return 1
	fi
	if [ ! -r "${avwebgate_cfg}" ]; then
		eerror "avwebgate config [${avwebgate_cfg}] missing"
		return 1
	fi
	if [ ! -r "${avwebgate_acl}" ]; then
		eerror "avwebgate acl [${avwebgate_acl}] missing"
		return 1
	fi
}

start() {
	checkconfig || return 1
	ebegin "Starting ${svc_name}"
	/sbin/start-stop-daemon --start --quiet --exec "${avwebgate_bin}"
	eend $?
}

stop() {
	checkconfig || return 2
	ebegin "Stopping ${svc_name}"
	/sbin/start-stop-daemon --stop --quiet --exec "${avwebgate_bin}"
	eend $?
}
