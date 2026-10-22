tag @s add this.self
execute if score @s data..damage_dealt matches 1.. as @a[scores={game.player.team_id=2}] run tag @s add this.selected
execute as @a[tag=this.selected] run function ./attack_killer:
    execute on attacker if entity @s[tag=this.self] expand:
        execute at @s function ./use_ability:
            scoreboard players add @s skill.runner.brawler.uses 1
            scoreboard players set @s skill.runner.brawler.cooldown 300
            anchored eyes run particle sweep_attack ^ ^ ^2 0.3 0.6 0.3 0 1 normal @a
        execute at @s as @n[tag=this.selected] run function ./stun_killer:
            scoreboard players add @s time.player.stun_timer 30
            scoreboard players add @s time.player.assist_timer 40
            playsound minecraft:block.glass.break player @a ~ ~ ~ 0.1 2
        tag @a remove this.selected
tag @s remove this.self
tag @a remove this.selected

execute if score @s skill.runner.brawler.cooldown matches 1.. run function ./tick_cooldown:
    scoreboard players remove @s skill.runner.brawler.cooldown 1
    execute if score @s skill.runner.brawler.uses matches 3 expand:
        attribute @s minecraft:attack_damage modifier add ./cooldown -1 add_multiplied_base
        attribute @s minecraft:attack_speed modifier add ./cooldown -1 add_multiplied_base
        execute at @a[scores={game.player.team_id=2}] run particle crit ~ ~1 ~ 0.3 0.6 0.3 0 1 force @s
    
execute if score @s skill.runner.brawler.cooldown matches 0 run function ./end_cooldown:
    scoreboard players reset @s skill.runner.brawler.uses
    scoreboard players reset @s skill.runner.brawler.cooldown
    attribute @s minecraft:attack_damage modifier remove ./cooldown
    attribute @s minecraft:attack_speed modifier remove ./cooldown
    at @s run playsound minecraft:entity.vindicator.celebrate player @s ~ ~ ~ 0.1 2