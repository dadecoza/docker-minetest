FROM debian:buster
MAINTAINER Johannes le Roux <dade@dade.co.za>

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libirrlicht-dev \
    libbz2-dev \
    libgettextpo-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libxxf86vm-dev \
    libgl1-mesa-dev \
    libsqlite3-dev \
    libogg-dev \
    libvorbis-dev \
    libopenal-dev \
    libhiredis-dev \
    libcurl3-dev \
    libsqlite3-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libjsoncpp-dev \
    unzip

ADD src/minetest.tar.gz /opt
ADD src/minetest_game.tar.gz /opt/minetest/games

WORKDIR /opt/minetest

RUN cmake . \
    -DENABLE_GETTEXT=1 \
    -DENABLE_FREETYPE=1 \
    -DENABLE_LEVELDB=1 \
    -DENABLE_REDIS=1 \
    -DBUILD_CLIENT=0 \
    -DENABLE_SYSTEM_JSONCPP=1 \
    -DENABLE_SOUND=0 \
    -DBUILD_SERVER=1 && \
    make -j$(grep -c processor /proc/cpuinfo)

ADD mods/mods.tar.gz /opt/minetest/
ADD worlds/world.tar.gz /opt/minetest/worlds/
COPY conf/minetest.conf /opt/minetest/

ENV MINETEST_WORLD_PATH=/opt/minetest/worlds

EXPOSE 30000/udp

CMD ["/opt/minetest/bin/minetestserver", "--config", "/opt/minetest/minetest.conf", "--gameid", "minetest_game", "--worldname", "world"]
