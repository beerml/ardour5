# Created by: Michael Beer <beerml@sigma6audio.de>
# $FreeBSD$

PORTNAME=	ardour5
PORTVERSION=	5.4.0
CATEGORIES=	audio
MASTER_SITES=	https://github.com/beerml/ardour_releases/raw/master/ \
		http://github.com/beerml/ardour_releases/raw/master/
# The original master side points to the latest release only:
# MASTER_SITES=	https://community.ardour.org/srctar/
DISTNAME=	Ardour-${PORTVERSION}

MAINTAINER=	beerml@sigma6audio.de
COMMENT=	Ardour - the digital audio workstation

LICENSE=	GPLv2+
LICENSE_FILE=	${WRKSRC}/COPYING

BUILD_DEPENDS=	lv2>=1.14.0:audio/lv2 itstool>2.0.0:textproc/itstool

LIB_DEPENDS=	libserd-0.so:audio/serd \
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

USES=		desktop-file-utils gettext-runtime libarchive pkgconfig \
		python:build readline tar:bzip2 waf

USE_XORG=	x11

USE_GNOME=	atk cairo cairomm gdkpixbuf2 glib20 glibmm gtk20 gtkmm24 pango

USE_LDCONFIG=	yes

INSTALLS_ICONS=	yes

CONFIGURE_ARGS=	--optimize --ptformat --freedesktop --no-phone-home \
		--with-backends=jack,dummy --internal-shared-libs \
		--also-include=/usr/local/include --also-libdir=/usr/local/lib

post-patch:
# can be removed when Ardour 5.5.0 is released
	@${REINPLACE_CMD} -e 's/'\''_POSIX_SOURCE'\''/'\''_POSIX_SOURCE'\'','\''_POSIX_C_SOURCE=200809'\'','\''_XOPEN_SOURCE=700'\''/g' ${WRKSRC}/libs/fst/wscript

post-install:
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/appdata
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/applications
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/16x16/apps
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/22x22/apps
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/32x32/apps
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/48x48/apps
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/256x256/apps
	@${MKDIR} ${STAGEDIR}${PREFIX}/share/icons/hicolor/512x512/apps
	@${CP} ${WRKSRC}/build/gtk2_ardour/ardour5.appdata.xml \
		${STAGEDIR}${PREFIX}/share/appdata/ardour5.appdata.xml
	@${CP} ${WRKSRC}/build/gtk2_ardour/ardour5.desktop \
		${STAGEDIR}${PREFIX}/share/applications/ardour5.desktop
	@${CP} ${STAGEDIR}${PREFIX}/share/ardour5/resources/Ardour-icon_16px.png \
		${STAGEDIR}${PREFIX}/share/icons/hicolor/16x16/apps/ardour5.png
	@${CP} ${STAGEDIR}${PREFIX}/share/ardour5/resources/Ardour-icon_22px.png \
		${STAGEDIR}${PREFIX}/share/icons/hicolor/22x22/apps/ardour5.png
	@${CP} ${STAGEDIR}${PREFIX}/share/ardour5/resources/Ardour-icon_32px.png \
		${STAGEDIR}${PREFIX}/share/icons/hicolor/32x32/apps/ardour5.png
	@${CP} ${STAGEDIR}${PREFIX}/share/ardour5/resources/Ardour-icon_48px.png \
		${STAGEDIR}${PREFIX}/share/icons/hicolor/48x48/apps/ardour5.png
	@${CP} ${STAGEDIR}${PREFIX}/share/ardour5/resources/Ardour-icon_256px.png \
		${STAGEDIR}${PREFIX}/share/icons/hicolor/256x256/apps/ardour5.png
	@${CP} ${STAGEDIR}${PREFIX}/share/ardour5/resources/Ardour-icon_512px.png \
		${STAGEDIR}${PREFIX}/share/icons/hicolor/512x512/apps/ardour5.png
	@${FIND} ${STAGEDIR}${PREFIX}/lib/${PORTNAME} \
		-name '*.so*' -exec ${STRIP_CMD} {} +
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/sanityCheck
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/utils/ardour5-copy-mixer
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/utils/ardour5-export
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/ardour-exec-wrapper
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/ardour-vst-scanner
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/luasession
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/ardour-${PORTVERSION}
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/utils/ardour5-fix_bbtppq
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/hardour-${PORTVERSION}

.include <bsd.port.mk>
