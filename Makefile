# Created by: Michael Beer <beerml@sigma6audio.de>
# $FreeBSD$

PORTNAME=	Ardour
PORTVERSION=	5.3.0
CATEGORIES=	audio
MASTER_SITES=	https://community.ardour.org/srctar/

MAINTAINER=	beerml@sigma6audio.de
COMMENT=	Ardour - the digital audio workstation

LICENSE=	GPLv2+
LICENSE_FILE=	${WRKSRC}/COPYING

BUILD_DEPENDS=	lv2>=1.12.0:audio/lv2 itstool>0:textproc/itstool

LIB_DEPENDS=    libserd-0.so:audio/serd \
		libsord-0.so:audio/sord \
		libsratom-0.so:audio/sratom \
		liblilv-0.so:audio/lilv \
		libsuil-0.so:audio/suil \
		libaubio.so:audio/aubio \
		librubberband.so:audio/rubberband \
		liblo.so:audio/liblo \
		liblrdf.so:textproc/liblrdf \
		libjack.so:audio/jack \
		libfontconfig.so:x11-fonts/fontconfig \
		libfreetype.so:print/freetype2 \
		libboost_date_time.so:devel/boost-libs \
		libvamp-hostsdk.so:audio/vamp-plugin-sdk \
		libsamplerate.so:audio/libsamplerate \
		libsndfile.so:audio/libsndfile \
		libtag.so:audio/taglib \
		libfftw3f.so:math/fftw3-float \
		libcurl.so:ftp/curl \
		libogg.so:audio/libogg \
		libFLAC.so:audio/flac \
		libreadline.so:devel/readline

USES=		pkgconfig python:build tar:bzip2 waf gettext-runtime readline

CONFIGURE_TARGET=  	configure --optimize --ptformat --freedesktop --no-phone-home \
			--also-include=/usr/local/include --also-libdir=/usr/local/lib

NLS_USES=       gettext

USE_XORG=       x11

USE_GNOME=      gtk20 gtkmm24 pango atk cairo cairomm gdkpixbuf2 glib20 glibmm

.if defined(BATCH) || defined(PACKAGE_BUILDING)
MAKE_ARGS+=	--verbose
.endif

post-patch:
	@${REINPLACE_CMD} -e 's/'\''_POSIX_SOURCE'\''/'\''_POSIX_SOURCE'\'','\''_POSIX_C_SOURCE=200809'\'','\''_XOPEN_SOURCE=700'\''/g' ${WRKSRC}/libs/fst/wscript

post-install:
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/appdata
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/applications
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/16x16/apps
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/22x22/apps
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/32x32/apps
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/48x48/apps
	@${MV} ${WRKSRC}/build/gtk_ardour/ardour5.appdata.xml \
		${STAGEDIR}${PREFIX}/share/appdata/ardour5.appdata.xml
	@${MV} ${WRKSRC}/build/gtk_ardour/ardour5.desktop \
		${STAGEDIR}${PREFIX}/share/applications/ardour5.desktop
	@${MV} ${STAGEDIR}${PREFIX}/share/ardour5/icons/application-x-ardour_16px.png \
		${STAGEDIR}${PREFIX}/share/icons/hicolor/16x16/apps/application-x-ardour5_16px.png
	@${MV} ${STAGEDIR}${PREFIX}/share/ardour5/icons/application-x-ardour_22px.png \
		${STAGEDIR}${PREFIX}/share/icons/hicolor/22x22/apps/application-x-ardour5_22px.png
	@${MV} ${STAGEDIR}${PREFIX}/share/ardour5/icons/application-x-ardour_32px.png \
		${STAGEDIR}${PREFIX}/share/icons/hicolor/32x32/apps/application-x-ardour5_32px.png
	@${MV} ${STAGEDIR}${PREFIX}/share/ardour5/icons/application-x-ardour_48px.png \
		${STAGEDIR}${PREFIX}/share/icons/hicolor/48x48/apps/application-x-ardour5_48px.png

.include <bsd.port.mk>
