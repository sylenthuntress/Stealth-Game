attribute @s minecraft:attack_damage modifier add game:stun -1 add_multiplied_total
attribute @s minecraft:movement_speed modifier add game:stun -1 add_multiplied_total
attribute @s minecraft:jump_strength modifier add game:stun -1 add_multiplied_total

scoreboard players remove @s time.player.stun_timer 1
execute if score @s time.player.stun_timer matches 0 run function game:gameplay/remove_stun:
    attribute @s minecraft:attack_damage modifier remove game:stun
    attribute @s minecraft:movement_speed modifier remove game:stun
    attribute @s minecraft:jump_strength modifier remove game:stun