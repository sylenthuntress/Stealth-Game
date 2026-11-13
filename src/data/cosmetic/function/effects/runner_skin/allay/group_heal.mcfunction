append function_tag event:group_heal {
    "values": [(~/)]
}

execute unless entity @s[tag=cosmetic.runner_skin.allay] run return fail

particle minecraft:heart ~ ~.5 ~ 0.75 0.2 0.75 0.6 3 normal @a
playsound minecraft:entity.allay.item_given player @a ~ ~ ~ 0.1 0.7


tag @s add this.self
execute as @e[type=item_display,tag=hiding_form] if score @s uid.entity = @p[tag=this.self] uid.player run tag @s add this.display
execute as @n[type=item_display,tag=this.display] run function animation:cosmetic/runner_skin/allay/hiding_form/variants/happy/apply
item modify entity @s armor.head {type:"minecraft:set_components",components:{"minecraft:profile":{texture:"hide_and_squeak:entity/player/cosmetic/runner_skin/allay/head_happy"}}}
tag @e remove this.display
tag @s remove this.self