execute function main:make_uid:
    scoreboard players operation @s uid.player = $uid.index uid.index
    scoreboard players add $uid.index uid.index 1

tellraw @s {"translate":"main.new_join","color":"yellow","with": [{"selector":"@s","color":"gold"},{"translate":"main.game_name","color":"gold","bold":true}]}
function lobby:join_lobby