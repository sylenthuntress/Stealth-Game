append function_tag cosmetic:effects/take_damage {
    "values": [(~/)]
}

execute unless entity @s[tag=cosmetic.runner_skin.allay] run return fail

playsound minecraft:entity.allay.hurt player @a[tag=game.viewing] ~ ~ ~ 0.5 2
function ./set_variant