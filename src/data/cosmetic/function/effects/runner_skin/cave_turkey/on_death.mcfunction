append function_tag cosmetic:effects/on_death {
    "values": [(~/)]
}

execute unless entity @s[tag=cosmetic.runner_skin.cave_turkey] run return fail

playsound minecraft:entity.chicken_picky.death player @a[tag=game.viewing] ~ ~ ~ 1 0.8 0.1