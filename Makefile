# Created by: Michael Beer <beerml@sigma6audio.de>
# $FreeBSD$

PORTNAME=	ardour
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

USES=		pkgconfig python:build tar:bzip2 waf gettext-runtime readline desktop-file-utils

CONFIGURE_TARGET=  	configure --optimize --ptformat --freedesktop --no-phone-home \
			--with-backends=jack,dummy --internal-shared-libs \
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
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/engines/libclearlooks.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/sanityCheck
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/libqmdsp.so.0.0.0
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/vamp/libardourvampplugins.so.0.0.0
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/libpbd.so.4.1.0
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/libevoral.so.0.0.0
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/libtimecode.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/libaudiographer.so.0.0.0
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/LV2/reasonablesynth.lv2/reasonablesynth.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/LV2/a-comp.lv2/a-comp.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/LV2/a-delay.lv2/a-delay.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/LV2/a-eq.lv2/a-eq.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/LV2/a-reverb.lv2/a-reverb.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/LV2/a-fluidsynth.lv2/a-fluidsynth.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/utils/ardour5-copy-mixer
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/utils/ardour5-export
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/ardour-exec-wrapper
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/ardour-vst-scanner
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/libardourcp.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/libardour.so.3.0.0
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/libgtkmm2ext.so.0.8.3
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/libcanvas.so.0.0.0
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/backends/libdummy_audiobackend.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/backends/libjack_audiobackend.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/libmidipp.so.4.1.0
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/surfaces/libardour_generic_midi.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/surfaces/libardour_mcp.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/surfaces/libardour_faderport.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/surfaces/libardour_osc.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/panners/libpan1in2out.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/panners/libpan2in2out.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/panners/libpanvbap.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/panners/libpanbalance.so
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/luasession
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/ardour-5.3.0
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/libptformat.so.0.0.0
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/ardour5/hardour-5.3.0

.include <bsd.port.mk>
