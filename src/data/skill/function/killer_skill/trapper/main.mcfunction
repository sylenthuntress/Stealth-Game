tag @s add this.selector
execute as @e[type=item,tag=skill.killer.trapper.dropped] at @s run function ./tick_item:
    execute if predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:flags":{is_on_ground:1b}}} run function ./set_trap:
        execute positioned ~-0.5 ~-0.1 ~-0.5 as @a[dx=1,dy=0.2,dz=1,team=runner] run return fail

        execute function ./spawn_trap:
            execute unless entity @a[tag=this.selector] run return fail
            summon marker ~ ~ ~ {Tags:["skill.killer.trapper.trap","skill.killer.trapper.trap.armed"]}
            summon minecraft:block_display ~ ~ ~ {Tags:["skill.killer.trapper.trap","skill.killer.trapper.trap.display"],block_state: "minecraft:polished_blackstone_pressure_plate", transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [1.0f, 0.1f, 1.0f], translation: [-0.5f, 0.0f, -0.5f]}}
            execute as @e[tag=skill.killer.trapper.trap] unless score @s uid.entity matches 0.. run scoreboard players operation @s uid.entity = @p[tag=this.selector] uid.player
            playsound minecraft:entity.evoker_fangs.attack master @p[tag=this.selector] ~ ~ ~ 0.1 0.8 0.1
        playsound minecraft:entity.evoker_fangs.attack master @a ~ ~ ~ 0.8 0.8
        kill @s

execute as @e[tag=skill.killer.trapper.trap] if score @s uid.entity = @p[tag=this.selector] uid.player run tag @s add this.selected
execute as @e[tag=this.selected] at @s run function ./tick_trap:
    execute if entity @s[type=marker,tag=skill.killer.trapper.trap.armed] positioned ~-0.5 ~-0.1 ~-0.5 as @a[dx=1,dy=0.2,dz=1,team=runner] at @s run function ./trigger_trap:
        damage @s 6.0 minecraft:magic by @p[tag=this.selector]
        scoreboard players add @s time.player.stun_timer 145
        effect give @s glowing 5 0 true

        particle ash ~ ~1 ~ 0.5 0.5 0.5 0 100
        playsound minecraft:block.stone_pressure_plate.click_on player @a ~ ~ ~ 1 0.5
        playsound minecraft:ui.stonecutter.take_result master @a ~ ~ ~ 1 0.5
        playsound minecraft:ui.stonecutter.take_result master @p[tag=this.selector] ~ ~ ~ 1 0.5 1
        playsound minecraft:block.note_block.bell master @p[tag=this.selector] ~ ~ ~ 1 0.55 1
        execute as @e[tag=this.selected] at @s expand:
            summon evoker_fangs ~ ~ ~ {Warmup:-1,Silent:1b}
            data modify entity @n[type=evoker_fangs] Owner set from entity @p[tag=this.selector] UUID
            kill @s
    tag @s remove this.selected
tag @s remove this.selector