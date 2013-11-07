# $FreeBSD$

PORTNAME=	one-context
PORTVERSION=	4.2.1
PORTREVISION=	0
CATEGORIES=	sysutils

MASTER_SITES=
DISTFILES=

MAINTAINER=	slb-freebsd-ports@silent.co.uk
COMMENT=	OpenNebula contextualisation scripts for FreeBSD

USE_RC_SUBR=	vmcontext

NO_WRKSUBDIR=	YES
NO_BUILD=	YES

do-install:
	@${MKDIR} -p ${STAGEDIR}${PREFIX}/etc/one-context.d
	@${MKDIR} -p ${STAGEDIR}${DATADIR}/one-context.d
	@for f in network dns ssh_public_key mount-swap execute-scripts; do \
		${CP} -p \
		${FILESDIR}/$$f \
		${STAGEDIR}${DATADIR}/one-context.d/$$f.sample ; \
	done

.include <bsd.port.mk>
