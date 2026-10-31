append function_tag items:process_special {
    "values": [(./process_item)]
}

execute unless items entity @s contents *[custom_data~{skill.killer.trapper.ability: true}] run return fail
execute on origin run scoreboard players remove @s skill.killer.trapper.count 1

execute unless score @s uid.entity matches 0.. on origin run scoreboard players operation @n[type=item] uid.entity = @s uid.player

tag @s add skill.killer.trapper.dropped
tag @s add items.nopickup