FROM debian:latest
MAINTAINER Johannes le Roux <dade@dade.co.za>


RUN apt -y update && \
    apt -y install \
    g++ \
    make \
    libc6-dev \
    cmake \
    libpng-dev \
    libjpeg-dev \
    libxxf86vm-dev \
    libgl1-mesa-dev \
    libsqlite3-dev \
    libogg-dev \
    libvorbis-dev \
    libopenal-dev \
    libcurl4-gnutls-dev \
    libfreetype6-dev \
    zlib1g-dev \
    libgmp-dev \
    libjsoncpp-dev \
    libzstd-dev \
    git \
    unzip


RUN git clone --depth 1 https://github.com/minetest/minetest.git /opt/minetest
RUN git clone --depth 1 https://github.com/minetest/minetest_game.git /opt/minetest/games/minetest_game
RUN git clone --depth 1 https://github.com/minetest/irrlicht.git /opt/minetest/lib/irrlichtmt

WORKDIR /opt/minetest

RUN cmake . \
    -DENABLE_GETTEXT=1 \
    -DENABLE_FREETYPE=1 \
    -DENABLE_LEVELDB=1 \
    -DENABLE_REDIS=1 \
    -DBUILD_CLIENT=0 \
    -DENABLE_SYSTEM_JSONCPP=1 \
    -DENABLE_SOUND=0 \
    -DBUILD_SERVER=1 \
    -DRUN_IN_PLACE=1 && \
    make -j$(nproc)

ADD mods/mods.tar.gz /opt/minetest/
ADD worlds/world.tar.gz /opt/minetest/worlds/
COPY conf/minetest.conf /opt/minetest/

ENV MINETEST_WORLD_PATH=/opt/minetest/worlds

EXPOSE 30000/udp

CMD ["/opt/minetest/bin/minetestserver", "--config", "/opt/minetest/minetest.conf", "--gameid", "minetest_game", "--worldname", "world"]
