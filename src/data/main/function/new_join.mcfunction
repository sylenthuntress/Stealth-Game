function game:make_uid:
    scoreboard players operation @s uid.player = $uid.index uid.index
    scoreboard players add $uid.index uid.index 1

tellraw @s {"translate":"main.new_join","color":"yellow","with": [{"selector":"@s","color":"gold"},{"translate":"main.game_name","color":"gold","bold":true}]}
execute if score $game gamestate matches 0 run function game:lobby/spawn
execute if score $game gamestate matches 1 run function game:game/spawn

team join lobby
execute if entity @s[name=SylentHuntress] run team join dev