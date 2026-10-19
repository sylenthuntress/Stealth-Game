advancement revoke @s only skill:killer_skill/athlete/use_ability
scoreboard players set @s skill.killer.athlete.cooldown 300
scoreboard players set @s skill.killer.athlete.dash_timer 40

item modify entity @s skill:killer_skill/athlete/ability skill:killer_skill/athlete/disable_ability 
item modify entity @s skill:killer_skill/athlete/cooldown skill:killer_skill/athlete/set_cooldown

playsound minecraft:entity.blaze.shoot player @a ~ ~ ~ 2 1 0.1