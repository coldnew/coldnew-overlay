PORTDIR_OVERLAY of Yen-Chin,Lee <coldnew.tw@gmail.com>
-----------------------------------------------------
This overlay contains some experimental stuff, but mostly stuff I quickly wrote
an ebuild for or grabed it from bugzilla and did not have the time to commit it
to the official tree or do not consider it ready for it.

INSTALL :

    sudo wget https://raw.github.com/coldnew/coldnew-overlay/master/coldnew-overlay.xml -O /etc/layman/overlays

  Then:

     layman -L
     layman -a coldnew

  OR Use Following Command Directly:

     layman -o https://raw.github.com/coldnew/coldnew-overlay/master/coldnew-overlay.xml -f -a coldnew

After this you can emerge everything from this overlay.
