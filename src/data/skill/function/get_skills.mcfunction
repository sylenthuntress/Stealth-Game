data remove storage skill:selection Recursive

$execute if score @s game.player.team_id matches 1 run data modify storage skill:selection Recursive append from storage skill:selection selections[{"uid": $(uid)}].skills[{"runner_skill": true}]
$execute if score @s game.player.team_id matches 2 run data modify storage skill:selection Recursive append from storage skill:selection selections[{"uid": $(uid)}].skills[{"killer_skill": true}]
$execute if score @s game.player.team_id matches 2 run data modify storage skill:selection Recursive append from storage skill:selection selections[{"uid": $(uid)}].skills[{"weapon": true}]
$data modify storage skill:selection Recursive set from storage skill:selection selections[{"uid": $(uid)}].skills
