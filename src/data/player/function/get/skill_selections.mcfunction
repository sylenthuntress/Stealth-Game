data modify storage player:data selected.skills set value []
execute store result storage player:data selected.uid int 1 run scoreboard players get @s uid.player
function ./../internal/skill_selections with storage player:data selected 
function ./../internal/skill_selections:
    $data modify storage player:data selected.skills append from storage skill:data Selection.players[{"uid": $(uid)}].skills[]