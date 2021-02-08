FROM debian:stretch

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
      live-build \
      liblzo2-2 \
      squashfs-tools \
      git \
      ca-certificates && \
      mkdir /build /config /result
VOLUME ["/result", "/config"]
COPY ./generate-iso.sh /generate-iso.sh
#COPY ./generate-rootfs.sh /generate-rootfs.sh
ADD ./mobile.sh /result
ADD ./pure.sh /result
ADD ./psion.sh /result
WORKDIR /build
ENTRYPOINT ["/generate-iso.sh"]
#ENTRYPOINT ["/generate-rootfs.sh"]
RUN bash -c "/result/pure.sh"
RUN bash -c "/result/psion.sh"
