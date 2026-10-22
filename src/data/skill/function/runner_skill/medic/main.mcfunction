execute if score @s skill.runner.medic.count matches 0 run return fail
execute if entity @s[gamemode=spectator,team=dead] run return fail

scoreboard players add $time skill.runner.medic.heartbeat 1
execute if score $time skill.runner.medic.heartbeat matches 10 run scoreboard players set $time skill.runner.medic.heartbeat 0

execute at @s unless score @s time.player.heal_timer matches -10.. positioned ~-3 ~-1 ~-3 if entity @e[dx=6,dy=4,dz=6,type=mannequin,tag=game.runner_corpse,tag=!skill.runner_skill.undying.reviving,scores={time.player.corpse_age=..600}] run function ./display_hearts:
    scoreboard players operation $var skill.runner.medic.count = @s skill.runner.medic.count
    scoreboard players operation $var skill.runner.medic.uses = @s skill.runner.medic.uses
    data remove storage skill:data RunnerSkill.Medic.hearts
    execute function ./display_hearts_r:
        execute if score $var skill.runner.medic.count matches 1.. expand:
            if score $time skill.runner.medic.heartbeat matches 0..5 run data modify storage skill:data RunnerSkill.Medic.hearts append value {"text":"❤","color":"#912525","bold":false}
            if score $time skill.runner.medic.heartbeat matches 6..10 run data modify storage skill:data RunnerSkill.Medic.hearts append value {"text":"♥","color":"#912525","bold":false}
            scoreboard players remove $var skill.runner.medic.count 1
        execute unless score $var skill.runner.medic.count matches 1.. if score $var skill.runner.medic.uses matches 1.. expand: 
            data modify storage skill:data RunnerSkill.Medic.hearts append value {"text":"♡","color":"#b17070"}
            scoreboard players remove $var skill.runner.medic.uses 1
        execute unless score $var skill.runner.medic.count matches ..0 unless score $var skill.runner.medic.uses matches ..0 run function ./display_hearts_r
        execute if score $var skill.runner.medic.count matches 1.. if score $var skill.runner.medic.uses matches ..0 run function ./display_hearts_r
    function ./display_hearts_m with storage skill:data RunnerSkill.Medic

tag @s add this.self
execute as @e[type=mannequin,tag=game.runner_corpse,tag=!skill.runner_skill.undying.reviving] at @s run function ./show_beam:
    execute if score @s time.player.corpse_age matches 600.. run return fail
    particle dust{color:[1,0,0], scale:1} ~ ~10 ~ 0 10 0 0 50 force @a[tag=this.self]

execute at @s if score @s time.player.heal_timer matches -10.. positioned ~-3 ~-1 ~-3 if entity @e[dx=6,dy=4,dz=6,type=mannequin,tag=game.runner_corpse,tag=!skill.runner_skill.undying.reviving] at @s run function ./reviving:
    execute if score @s time.player.corpse_age matches 600.. run return fail
    execute as @n[type=mannequin,tag=game.runner_corpse] expand:
            effect give @s glowing 2 0 true
            tag @s add this.selector
            execute as @a[team=dead] if score @s uid.player = @n[tag=this.selector] uid.entity run tag @s add this.selected
            tag @s remove this.selector
            scoreboard players add @s skill.runner.medic.revive_timer 1
            scoreboard players remove @s time.player.corpse_age 1
    i = 0
    completeHearts = ""
    incompleteHearts = "♡♡♡♡♡♡♡♡♡♡"
    for n in range(200):
        if n % 20 == 0:
            execute if score @n[type=mannequin,tag=game.runner_corpse] skill.runner.medic.revive_timer matches n run playsound minecraft:item.flintandsteel.use master @s ~ ~ ~ 1 (0.5 + i/40)
            execute if score @n[type=mannequin,tag=game.runner_corpse] skill.runner.medic.revive_timer matches n run title @s actionbar [{"text":completeHearts,"color":"red"},{"text":incompleteHearts,"color":"dark_gray"}]
            completeHearts += "❤"
            incompleteHearts = incompleteHearts[:-1]
            i += 1
    execute as @p[tag=this.selected] at @s rotated as @s expand:
        playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 0.7
        particle minecraft:soul ~ ~1 ~ 0.1 0.2 0.1 0 1 force @a[tag=this.self]
        facing entity @n[type=mannequin,tag=game.runner_corpse,distance=6..] feet run tp ^ ^0.7 ^3
        rotate @s facing entity @n[type=mannequin,tag=game.runner_corpse,distance=9..] feet
        if score @n[type=mannequin,tag=game.runner_corpse] skill.runner.medic.revive_timer matches 150.. spectate @n[type=mannequin,tag=game.runner_corpse]

    execute if score @s time.player.heal_timer matches 1 run function ./attempt_revive:
        execute if score @n[type=mannequin,tag=game.runner_corpse] skill.runner.medic.revive_timer matches 200.. run function ./revive:
            execute as @p[tag=this.selected] expand:
                team join runner
                gamemode adventure
                teleport @n[type=mannequin,tag=game.runner_corpse]
                scoreboard players reset @s game.player.injury
                scoreboard players reset @s game.player.damage
                scoreboard players add @s game.player.points_split 1
                function skill:on_disable
                function skill:disable_skills
                at @s run playsound minecraft:item.totem.use master @a[tag=game.playing] ~ ~ ~ 2 1 1
            execute as @n[type=mannequin,tag=game.runner_corpse] at @s expand:
                function game:gameplay/runner/kill_corpse
            tellraw @a[tag=game.playing] {"color":"gold","translate":"skill.runner.medic.revive","with":[{"selector":"@s"},{"selector":"@p[tag=this.selected]"}]}
            scoreboard players operation @p[tag=this.selected] skill.runner.medic.revive_uid = @s uid.player
            scoreboard players remove @s skill.runner.medic.count 1
            scoreboard players add @s skill.runner.medic.uses 1
            scoreboard players operation $var game.player.due_points += $gamestate gamestate.band_progression
            scoreboard players operation $var game.player.due_points *= $3 math.const
            scoreboard players operation @s game.player.due_points += $var game.player.due_points
            scoreboard players reset $var game.player.due_points
        tag @a remove this.selected

        particle minecraft:heart ~ ~.5 ~ 0.75 0.2 0.75 0.6 3 normal @a
        playsound minecraft:entity.bat.ambient player @a ~ ~ ~ 0.1 0.7
tag @s remove this.self