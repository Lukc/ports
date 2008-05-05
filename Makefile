#
#  ports - update/list ports collection
#
#  Copyright (c) 2002-2005 Per Liden <per@fukt.bth.se> 
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

DESTDIR	 =
BINDIR	 = /usr/bin
MANDIR	 = /usr/man
ETCDIR	 = /etc/ports
PORTSDIR = /usr/ports

VERSION  = 1.5

all: ports ports.8

%: %.in
	sed "s/#VERSION#/$(VERSION)/" $< > $@

.PHONY:	install dist clean

install: all
	install -D -m0755 ports $(DESTDIR)$(BINDIR)/ports
	install -D -m0644 ports.8 $(DESTDIR)$(MANDIR)/man8/ports.8
	install -d $(DESTDIR)$(ETCDIR)/drivers
	install -d $(DESTDIR)$(PORTSDIR)

dist: clean
	(cd .. && tar czvf ports-$(VERSION).tar.gz ports-$(VERSION))

clean:
	rm -f ports ports.8

# End of file
