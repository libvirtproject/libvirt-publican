# THIS FILE WAS AUTO-GENERATED
#
#  $ lcitool dockerfile fedora-rawhide libvirt-publican
#
# https://gitlab.com/libvirt/libvirt-ci/-/commit/d527e0c012f476c293f3bc801b7da08bc85f98ef
FROM registry.fedoraproject.org/fedora:rawhide

RUN dnf install -y nosync && \
    echo -e '#!/bin/sh\n\
if test -d /usr/lib64\n\
then\n\
    export LD_PRELOAD=/usr/lib64/nosync/nosync.so\n\
else\n\
    export LD_PRELOAD=/usr/lib/nosync/nosync.so\n\
fi\n\
exec "$@"' > /usr/bin/nosync && \
    chmod +x /usr/bin/nosync && \
    nosync dnf update -y --nogpgcheck fedora-gpg-keys && \
    nosync dnf update -y && \
    nosync dnf install -y \
        ca-certificates \
        git \
        glibc-langpack-en \
        publican && \
    nosync dnf autoremove -y && \
    nosync dnf clean all -y && \
    rpm -qa | sort > /packages.txt

ENV LANG "en_US.UTF-8"
