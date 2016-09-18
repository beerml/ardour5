# Created by: Michael Beer <beerml@sigma6audio.de>
# $FreeBSD$

PORTNAME=	Ardour
PORTVERSION=	5.3.0
CATEGORIES=	audio
MASTER_SITES=	https://community.ardour.org/srctar/

MAINTAINER=	beerml@sigma6audio.de
COMMENT=	Ardour - the digital audio workstation.

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/COPYING

LIB_DEPENDS=    libserd-0.so:audio/serd libsord-0.so:audio/sord libsratom-0.so:audio/sratom liblilv-0.so:audio/lilv libsuil-0.so:audio/suil libaubio.so:audio/aubio librubberband.so:audio/rubberband liblo.so:audio/liblo liblrdf.so:textproc/liblrdf libjack.so:audio/jack

USES=		pkgconfig python:build tar:bzip2 waf gettext-runtime

CONFIGURE_TARGET=  configure --optimize --no-lxvst --ptformat --also-include=/usr/local/include --also-libdir=/usr/local/lib

NLS_USES=       gettext

USE_GNOME=      gtk20 pango atk cairo gdkpixbuf2 glib20

.if defined(BATCH) || defined(PACKAGE_BUILDING)
MAKE_ARGS+=	--verbose
.endif

.include <bsd.port.mk>
