append function_tag cosmetic:effects/on_death {
    "values": [(~/)]
}

execute unless function ./has_skin run return fail

playsound minecraft:entity.bee.death player @a[tag=game.viewing] ~ ~ ~ 1 1.5 0.1