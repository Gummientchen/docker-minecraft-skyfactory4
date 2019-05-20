FROM java:8

MAINTAINER Tim Chaubet <tim@chaubet.be>

RUN apt-get install -y wget unzip sudo
RUN addgroup --gid 1234 minecraft
RUN adduser --disabled-password --home=/data --uid 1234 --gid 1234 --gecos "minecraft user" minecraft

RUN mkdir /tmp/feed-the-beast && cd /tmp/feed-the-beast && \
 wget -c https://minecraft.curseforge.com/projects/skyfactory-4/files/2706808/download -O SkyFactory_4_Server.zip && \
 unzip SkyFactory_4_Server.zip && \
 rm SkyFactory_4_Server.zip && \
 bash -x Install.sh && \
 chown -R minecraft /tmp/feed-the-beast

USER minecraft

EXPOSE 25565

ADD --chown minecraft:minecraft start.sh /start.sh
RUN chmod +x /start.sh

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

CMD ["/start.sh"]

ENV MOTD "A Minecraft (FTB SkyFactory 4) Server Powered by Docker"
ENV LEVEL world
ENV JVM_OPTS "-Xms2048m -Xmx2048m"
