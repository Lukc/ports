#
#  ports - update/list ports collection
#
#  Copyright (c) 2002-2005 Per Liden <per@fukt.bth.se> 
#  Copyright (c) 2011 Luka Vandervelden <lukc@upyum.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
#  USA.
#

DESTDIR    =
PREFIX     = /usr
BINDIR     = ${PREFIX}/bin
MANDIR     = ${PREFIX}/share/man
SYSCONFDIR = /etc
FILESDIR   = ${SYSCONFDIR}/ports
PORTSDIR   = ${PREFIX}/ports

VERSION  = 1.6

Q ?= @

all: ports ports.8

%: %.in
	@echo "-- Building $@."
	$Qsed -e "s/#VERSION#/${VERSION}/" $^ > $@

.PHONY:	install dist clean

install: install-ports install-ports.8 install-dirs install-drivers

install-ports: all
	@echo "-- Installing ports."
	$Qmkdir -p ${DESTDIR}${BINDIR}
	$Qinstall -m0755 ports ${DESTDIR}${BINDIR}/ports
install-ports.8: all
	@echo "-- Installing ports.8."
	$Qmkdir -p ${DESTDIR}${MANDIR}/man8
	$Qinstall -m0644 ports.8 ${DESTDIR}${MANDIR}/man8/ports.8
install-dirs: all
	@echo "-- Creating ports directories."
	$Qmkdir -p ${DESTDIR}${FILESDIR}/drivers
	$Qmkdir -p ${DESTDIR}${PORTSDIR}

install-drivers: install-git install-rsync install-httpup

install-%: drivers/% install-dirs
	@echo "-- Installing `basename $<` driver."
	$Qinstall -m0755 $< ${DESTDIR}${FILESDIR}/$<
	

dist: dist-tgz dist-tbz2 dist-txz

dist-tgz: clean
	(cd .. && tar czvf ports-${VERSION}.tar.gz ports-${VERSION})
dist-tbz2: clean
	(cd .. && tar cjvf ports-${VERSION}.tar.bz2 ports-${VERSION})
dist-txz: clean
	(cd .. && tar cJvf ports-${VERSION}.tar.xz ports-${VERSION})

clean:
	@echo "-- Cleaning."
	$Qrm -f ports ports.8

# End of file
