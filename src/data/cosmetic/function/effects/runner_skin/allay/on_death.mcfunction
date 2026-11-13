append function_tag cosmetic:effects/on_death {
    "values": [(~/)]
}

execute unless entity @s[tag=cosmetic.runner_skin.allay] run return fail

playsound minecraft:entity.allay.death player @a[tag=game.viewing] ~ ~ ~ 1 1.5 0.1
item modify entity @n[type=mannequin,tag=game.runner_corpse] armor.head {type:"minecraft:set_components",components:{"minecraft:profile":{texture:"hide_and_squeak:entity/player/cosmetic/runner_skin/allay/head_dead"}}}