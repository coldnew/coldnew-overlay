 chown coldnew /var/tmp/portage/dev-libs/weston-8.0.0/work/weston-8.0.0
 chown coldnew /var/tmp/portage/dev-libs/weston-8.0.0/work
 chown coldnew /var/tmp/portage/dev-libs/weston-8.0.0/

chown -R coldnew /var/tmp/portage/dev-libs/weston-8.0.0/work/weston-8.0.0
rm /var/tmp/portage/dev-libs/weston-8.0.0/.compiled && rm /var/tmp/portage/dev-libs/weston-8.0.0/.installed  && USE="-test -xwayland" ebuild weston-8.0.0.ebuild digest compile install && cd /var/tmp/portage/dev-libs/weston-8.0.0/image/ && rsync -avr * / && cd -
 chown coldnew /var/tmp/portage/dev-libs/weston-8.0.0/work/weston-8.0.0
 chown coldnew /var/tmp/portage/dev-libs/weston-8.0.0/work
 chown coldnew /var/tmp/portage/dev-libs/weston-8.0.0/
