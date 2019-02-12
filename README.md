Minetest 0.4.17.1 Server with MODS and MOBS.

Mobs: Police, Prisoner, Zombie, Creeper, Archer

Mods: Vehicles, Ranged Weapons

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
