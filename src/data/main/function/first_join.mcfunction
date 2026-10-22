execute store result score @s uid.player run scoreboard players add $uid.index uid.index 1

tellraw @s {"translate":"main.new_join","color":"yellow","with": [{"selector":"@s","color":"gold"},{"translate":"main.game_name","color":"gold","bold":true}]}
function lobby:join_lobby