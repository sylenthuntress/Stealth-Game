scoreboard objectives add var.candidates dummy
scoreboard objectives add var.queue dummy

execute as @a[tag=playing,sort=random,tag=!killer_blacklist] store result score @s var.queue run scoreboard players add $var var.candidates 100
execute as @a[tag=playing,tag=killer_blacklist] run scoreboard players add $var var.candidates 100

scoreboard players operation $var var.candidates /= $100 math.const
scoreboard players operation $var var.candidates *= $config config.killer_ratio

execute as @a[tag=playing,tag=!killer_blacklist] if score @s var.queue <= $var var.candidates run scoreboard players set @s game.player.team_id 2
tag @a[scores={game.player.team_id=2}] add killer_blacklist

scoreboard objectives remove var.candidates
scoreboard objectives remove var.queue