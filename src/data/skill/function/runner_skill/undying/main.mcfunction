execute if entity @s[gamemode=spectator,team=dead] at @s run function skill:runner_skill/undying/attempt_revive:
    tag @s add this.selector
    execute as @e[type=mannequin,tag=game.runner_corpse] if score @s uid.entity = @p[tag=this.selector] uid.player run tag @s add this.selected
    tag @s remove this.selector

    i = 0
    completeHearts = ""
    incompleteHearts = "♡♡♡♡♡♡♡♡♡♡"
    for n in range(400):
        if n % 40 == 0:
            execute if score @n[type=mannequin,tag=this.selected] time.player.corpse_age matches (n, n+40) run playsound minecraft:block.note_block.bit master @s ~ ~ ~ (2 - (i/5.1)) 0.5
            execute if score @n[type=mannequin,tag=this.selected] time.player.corpse_age matches n run playsound minecraft:entity.wither.shoot master @s ~ ~ ~ (0 + (i/5)) (0.5 + i/40)
            execute if score @n[type=mannequin,tag=this.selected] time.player.corpse_age matches n run title @s actionbar [{"text":completeHearts,"color":"#56add8"},{"text":incompleteHearts,"color":"dark_gray"}]
            completeHearts += "❤"
            incompleteHearts = incompleteHearts[:-1]
            i += 1
    tag @n[tag=this.selected] add skill.runner_skill.undying.reviving

    spectate @n[type=mannequin,tag=this.selected]
    execute if score @n[tag=this.selected] time.player.corpse_age matches 300.. run effect give @n[tag=this.selected] glowing 5 0 true
    execute if score @n[tag=this.selected] time.player.corpse_age matches 400.. run function skill:runner_skill/undying/revive:
        team join runner
        gamemode adventure
        teleport @n[type=mannequin,tag=this.selected]
        scoreboard players reset @s game.player.injury
        scoreboard players reset @s game.player.damage
        scoreboard players add @s game.player.points_split 1
        function skill:on_disable
        function skill:disable_skills
        execute at @s run playsound minecraft:item.totem.use master @a[tag=playing] ~ ~ ~ 2 1 1
        execute at @s run playsound minecraft:entity.wither.spawn player @a[tag=playing] ~ ~ ~ 0.5 2 0.5
        execute as @n[type=mannequin,tag=this.selected] at @s expand:
            function game:gameplay/runner/kill_corpse
        tellraw @a[tag=playing] {"color":"#56add8","translate":"skill.runner.undying.revive","with":[{"selector":"@s"}]}
        
        scoreboard players reset @s skill.runner.medic.revive_uid
    tag @e remove this.selected