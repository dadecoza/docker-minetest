Minetest 5.0.1 Server with MODS and MOBS.

Mobs: Police, Prisoner, Zombie, Creeper, Archer, Freddie, Granny, SWAT

Mods: Vehicles, Ranged Weapons

My 6yo enjoys police RP and I configured this server for him and his friends. This also serves as a backup for myself should I ever have to rebuild it.

I also hacked the minetest_game/mods/default/players.lua file to first check if there is a playername.png file before it selects the default character.png file. ie. each player can have his/her own skin ... see below how to add skins ...

### Build the server ...
```
git clone https://github.com/dadecoza/docker-minetest.git
cd docker-minetest
sudo docker build . -t dadecoza/minetest
```

### Start the server ...
```
docker run -p 30000:30000/udp -d --name minetest-server dadecoza/minetest
```

### Add custom player skins (minecraft 64x32 png skin files) ...
```
docker cp playername.png minetest-server:/opt/minetest/games/minetest_game/mods/default/models
docker restart minetest-server
```

The admin user is dadecoza. You can edit conf/minetest.conf to change it.
