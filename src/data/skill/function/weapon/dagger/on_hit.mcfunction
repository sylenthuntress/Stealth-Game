append function_tag event:on_hit {
    "values": [(~/)]
}

execute unless slots entity @s {type:"minecraft:filtered",slot_source:{type:"minecraft:slot_range",source:"this",slots:"weapon.mainhand"},item_filter:{predicates:{"minecraft:custom_data":{"skill.weapon.dagger":1b}}}} \
    run return fail # Run ONLY if the held weapon is a dagger

scoreboard players set @s time.player.recovery_timer 0