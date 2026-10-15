tag @s add this.selector
execute as @e[type=mannequin,tag=skill.killer_skill.gemini.clone] if score @s uid.entity = @p[tag=this.selector] uid.player run tag @s add this.selected

execute as @e[type=mannequin,tag=this.selected] at @s expand:
    store result score @s skill.killer.gemini.clone.curr_hp run data get entity @s Health
    on attacker run tag @s add this.attacker
    if score @s skill.killer.gemini.clone.curr_hp < @s skill.killer.gemini.clone.prev_hp if entity @a[tag=this.attacker,team=runner] run function skill:killer_skill/gemini/damage_mannequin:
        execute on attacker if entity @s[team=killer] run return fail

        scoreboard players remove @s skill.killer.gemini.clone.health 1
        execute on attacker at @s expand:
            scoreboard players add @s game.player.due_points 3
            damage @p[tag=this.selector] 1 minecraft:player_attack
        execute as @a[tag=this.selector] expand:
            playsound minecraft:block.slime_block.break master @a[tag=playing] ~ ~ ~ 2 2 1
            at @s run playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 1 2
            title @s actionbar {"translate":"skill.killer.gemini.clone.hurt","color":"red"}
            item modify entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:slime_ball","components":{"minecraft:custom_data":{"skill.killer.gemini.ability":true}}}} skill:killer_skill/gemini/display_health

        execute if score @s skill.killer.gemini.clone.health matches 0 run function skill:killer_skill/gemini/kill_mannequin:
            execute as @a[tag=this.selector] at @s expand:
                playsound minecraft:block.respawn_anchor.deplete master @a[tag=playing] ~ ~ ~ 2 1 1
                title @s actionbar {"translate":"skill.killer.gemini.clone.killed","color":"red"}
                tellraw @a[tag=playing] {"translate":"skill.killer.gemini.clone.announce_kill","color":"#7bd587","with":[{"selector":"@a[tag=this.selector]"},{"selector":"@a[tag=this.attacker]"}]}
                item replace entity @s {"type":"minecraft:filtered","slot_source":"util:inventory","item_filter":{"items":"minecraft:slime_ball","components":{"minecraft:custom_data":{"skill.killer.gemini.ability":true}}}} with air
            kill @s
    tag @a remove this.attacker
    scoreboard players operation @s skill.killer.gemini.clone.prev_hp = @s skill.killer.gemini.clone.curr_hp

execute as @e[scores={skill.killer.gemini.hide_teleport=0}] at @s as @n[type=mannequin,tag=skill.killer_skill.gemini.display] run function skill:killer_skill/gemini/kill_display:
    effect give @s minecraft:invisibility 1 0 true
    teleport ~ ~-100 ~
    kill @s
effect clear @e[scores={skill.killer.gemini.hide_teleport=0}] invisibility
# execute as @e[scores={skill.killer.gemini.hide_teleport=0}] at @s run teleport @n[type=mannequin,tag=skill.killer_skill.gemini.display]

scoreboard players reset @e[scores={skill.killer.gemini.hide_teleport=0}] skill.killer.gemini.hide_teleport
scoreboard players remove @e[scores={skill.killer.gemini.hide_teleport=1..}] skill.killer.gemini.hide_teleport 1

tag @s remove this.selector
tag @e remove this.selected