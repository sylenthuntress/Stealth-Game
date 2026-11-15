append function_tag event:on_hit {
    "values": [(~/)]
}

execute unless entity @s[tag=skill.runner.brawler] run return fail
execute unless entity @a[tag=event.attack_target,scores={game.player.team_id=2}] run return fail
execute unless data storage event:data context.attack_target.damage_source.is_direct run return fail
execute if score @s skill.runner.brawler.uses matches 3 run return fail

scoreboard players add @s skill.runner.brawler.uses 1
scoreboard players set @s skill.runner.brawler.cooldown 100
execute anchored eyes run particle sweep_attack ^ ^ ^2 0.3 0.6 0.3 0 1 normal @a

execute as @n[tag=event.attack_target,scores={game.player.team_id=2}] at @s run function ./stun_killer:
    scoreboard players add @s time.player.stun_timer 20
    scoreboard players add @s time.player.assist_timer 40
    playsound minecraft:block.glass.break player @a ~ ~ ~ 0.5 2