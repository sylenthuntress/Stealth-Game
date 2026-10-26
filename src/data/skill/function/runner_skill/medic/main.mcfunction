execute if score @s skill.runner.medic.count matches 0 run return fail
execute if entity @s[gamemode=spectator,team=dead] run return fail

scoreboard players add #time skill.runner.medic.heartbeat 1
execute if score #time skill.runner.medic.heartbeat matches 10 run scoreboard players set #time skill.runner.medic.heartbeat 0

execute at @s unless score @s time.player.heal_timer matches -10.. positioned ~-3 ~-1 ~-3 if entity @e[dx=6,dy=4,dz=6,type=mannequin,tag=game.runner_corpse,tag=!skill.runner_skill.undying.reviving,scores={time.player.corpse_age=..600}] run function ./display_hearts:
    scoreboard players operation #var skill.runner.medic.count = @s skill.runner.medic.count
    scoreboard players operation #var skill.runner.medic.uses = @s skill.runner.medic.uses
    data remove storage skill:data RunnerSkill.Medic.hearts
    execute function ./display_hearts_r:
        execute if score #var skill.runner.medic.count matches 1.. expand:
            if score #time skill.runner.medic.heartbeat matches 0..5 run data modify storage skill:data RunnerSkill.Medic.hearts append value {"text":"❤","color":"#912525","bold":false}
            if score #time skill.runner.medic.heartbeat matches 6..10 run data modify storage skill:data RunnerSkill.Medic.hearts append value {"text":"♥","color":"#912525","bold":false}
            scoreboard players remove #var skill.runner.medic.count 1
        execute unless score #var skill.runner.medic.count matches 1.. if score #var skill.runner.medic.uses matches 1.. expand: 
            data modify storage skill:data RunnerSkill.Medic.hearts append value {"text":"♡","color":"#b17070"}
            scoreboard players remove #var skill.runner.medic.uses 1
        execute unless score #var skill.runner.medic.count matches ..0 unless score #var skill.runner.medic.uses matches ..0 run function ./display_hearts_r
        execute if score #var skill.runner.medic.count matches 1.. if score #var skill.runner.medic.uses matches ..0 run function ./display_hearts_r
    function ./display_hearts_m with storage skill:data RunnerSkill.Medic

tag @s add this.self
execute as @e[type=mannequin,tag=game.runner_corpse,tag=!skill.runner_skill.undying.reviving] at @s run function ./show_beam:
    execute if score @s time.player.corpse_age matches 600.. run return fail
    particle dust{color:[1,0,0], scale:1} ~ ~10 ~ 0 10 0 0 50 force @a[tag=this.self]

execute at @s if score @s time.player.heal_timer matches -10.. positioned ~-3 ~-1 ~-3 if entity @e[dx=6,dy=4,dz=6,type=mannequin,tag=game.runner_corpse,tag=!skill.runner_skill.undying.reviving] at @s run function ./reviving:
    execute as @n[type=mannequin,tag=game.runner_corpse] expand:
            execute if score @s time.player.corpse_age matches 600.. run return fail
            effect give @s glowing 2 0 true
            tag @s add this.selector
            execute as @a[team=dead] if score @s uid.player = @n[tag=this.selector] uid.entity run tag @s add this.selected
            tag @s remove this.selector
            scoreboard players add @s skill.runner.medic.revive_timer 1
            scoreboard players remove @s time.player.corpse_age 1
    scoreboard players operation @s skill.runner.medic.reviving_uid = @p[tag=this.selected] uid.player 

    # Display revival progress
    i = 0
    completeHearts = ""
    incompleteHearts = "♡♡♡♡♡♡♡♡♡♡"
    for n in range(200):
        if n % 20 == 0:
            execute if score @n[type=mannequin,tag=game.runner_corpse] skill.runner.medic.revive_timer matches n run playsound minecraft:item.flintandsteel.use master @s ~ ~ ~ 1 (0.5 + i/40)
            execute if score @n[type=mannequin,tag=game.runner_corpse] skill.runner.medic.revive_timer matches n run function render:actionbar/set_actionbar {"duration": 30, "text": [{"text": "[", "color":"dark_red"},{"text":completeHearts,"color":"red"},{"text":incompleteHearts,"color":"dark_gray"},{"text": "]", "color":"dark_red"}]}
            completeHearts += "❤"
            incompleteHearts = incompleteHearts[:-1]
            i += 1
    
    # Indicate revival to the person being revived
    execute as @p[tag=this.selected] at @s rotated as @s expand:
        playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 0.7
        particle minecraft:soul ~ ~1 ~ 0.1 0.2 0.1 0 1 force @a[tag=this.self]
        facing entity @n[type=mannequin,tag=game.runner_corpse,distance=6..] feet run tp ^ ^0.7 ^3
        rotate @s facing entity @n[type=mannequin,tag=game.runner_corpse,distance=9..] feet
        if score @n[type=mannequin,tag=game.runner_corpse] skill.runner.medic.revive_timer matches 150.. spectate @n[type=mannequin,tag=game.runner_corpse]

    # Check conditions to revive, and then revive if possible
    execute if score @s time.player.heal_timer matches 1 run function ./attempt_revive:
        particle minecraft:heart ~ ~.5 ~ 0.75 0.2 0.75 0.6 3 normal @a
        playsound minecraft:entity.bat.ambient player @a ~ ~ ~ 0.1 0.7
        execute unless score @n[type=mannequin,tag=game.runner_corpse] skill.runner.medic.revive_timer matches 201.. run return fail # Guard Return

        # If successful:
        ## Respawn the selected runner
        execute as @p[tag=this.selected] expand:
            team join runner
            gamemode adventure
            teleport @n[type=mannequin,tag=game.runner_corpse]
            scoreboard players reset @s game.player.injury
            scoreboard players reset @s game.player.damage
            scoreboard players add @s game.player.points_split 1
            tag @s add skill.runner.medic.revived
            function game:gameplay/runner/update_injury
            function skill:disable_skills
            at @s run playsound minecraft:item.totem.use master @a[tag=game.viewing] ~ ~ ~ 2 1 1
        execute as @n[type=mannequin,tag=game.runner_corpse] at @s function game:gameplay/runner/kill_corpse # Kill corpse after respawning
        
        ## Credit all responsible medics
        execute as @a[tag=skill.runner.medic,scores={time.player.heal_timer=-10..}] if score @s skill.runner.medic.reviving_uid = @p[tag=this.selected] uid.player run tag @s add skill.runner.medic.give_credit
        
        execute store result storage skill:data RunnerSkill.Medic.selector.revived_uid int 1 run scoreboard players get @p[tag=this.selected] uid.player
        execute as @a[tag=skill.runner.medic.give_credit] run function ./give_credit:
            execute store result storage skill:data RunnerSkill.Medic.selector.medic_uid int 1 run scoreboard players get @s uid.player
            function ./add_credit with storage skill:data RunnerSkill.Medic.selector
            function ./add_credit:
                $data modify storage skill:data RunnerSkill.Medic.revival_credit.$(revived_uid).$(medic_uid) set value true 

        tellraw @a[tag=game.viewing] {"color":"gold","translate":"skill.runner.medic.revive","with":[{"selector":"@p[tag=this.selected]"},{"selector":"@a[tag=skill.runner.medic.give_credit]"}]}
        tag @a remove skill.runner.medic.give_credit        

        ## Deplete charges from all responsible medics
        scoreboard players remove @s skill.runner.medic.count 1
        scoreboard players add @s skill.runner.medic.uses 1

        ## Give points to all responsible medics
        scoreboard players operation #var game.player.due_points += #gamestate gamestate.band_progression
        scoreboard players operation #var game.player.due_points *= #3 math.const
        scoreboard players operation @s game.player.due_points += #var game.player.due_points
        scoreboard players reset #var game.player.due_points
    tag @a remove this.selected
tag @s remove this.self