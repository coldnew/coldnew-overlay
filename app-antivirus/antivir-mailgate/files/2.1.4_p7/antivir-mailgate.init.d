#!/sbin/runscript
## 2003 by H+BEDV Datentechnik GmbH,
## Wolfram Schlich <wschlich@antivir.de>

svc_name="AntiVir MailGate"

## required binaries
avmailgate_bin="/usr/lib/AntiVir/avmailgate.bin"

## required config files
avmailgate_cfg="/etc/avmailgate.conf"
avmailgate_acl="/etc/avmailgate.acl"

depend() {
	need net
	use logger dns
}

checkconfig() {
	if [ ! -x "${avmailgate_bin}" ]; then
		eerror "avmailgate binary [${avmailgate_bin}] missing"
		return 1
	fi
	if [ ! -r "${avmailgate_cfg}" ]; then
		eerror "avmailgate config [${avmailgate_cfg}] missing"
		return 1
	fi
	if [ ! -r "${avmailgate_acl}" ]; then
		eerror "avmailgate acl [${avmailgate_acl}] missing"
		return 1
	fi
}

start() {
	checkconfig || return 1
	ebegin "Starting ${svc_name}"
	"${avmailgate_bin}" --start
	eend $?
}

stop() {
	checkconfig || return 2
	ebegin "Stopping ${svc_name}"
	"${avmailgate_bin}" --stop
	eend $?
}
