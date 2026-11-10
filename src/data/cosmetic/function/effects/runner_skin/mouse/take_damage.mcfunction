append function_tag cosmetic:effects/take_damage {
    "values": [(~/)]
}

execute unless function ./has_skin run return fail

playsound minecraft:entity.bat.hurt player @a[tag=game.viewing] ~ ~ ~ 0.5 2
particle minecraft:block_crumble{block_state:"minecraft:gray_concrete"} ~ ~ ~ 0.2 0.6 0.2 0.1 10 normal