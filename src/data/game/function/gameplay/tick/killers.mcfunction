execute unless score @s time.player.recovery_timer matches 1.. function game:gameplay/killer/get_backdoor

# Manage attack recovery
execute if score @s time.player.recovery_timer matches 1.. run scoreboard players remove @s time.player.recovery_timer 1
execute if score @s time.player.recovery_timer matches 0 expand:
    attribute @s minecraft:movement_speed modifier remove game:gameplay/killer/recovery
    attribute @s minecraft:jump_strength modifier remove game:gameplay/killer/recovery
    attribute @s minecraft:attack_speed modifier remove game:gameplay/killer/recovery
    attribute @s minecraft:attack_damage modifier remove game:gameplay/killer/recovery
    scoreboard players reset @s time.player.recovery_timer