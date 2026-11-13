function player:get/cosmetics
data modify storage cosmetic:data Selection.Recursive set value []
execute if entity @s[scores={game.player.team_id=1}] run data modify storage cosmetic:data Selection.Recursive append from storage player:data selected.cosmetics[{"type": "cosmetic:runner/skin"}]
execute if entity @s[scores={game.player.team_id=2}] run data modify storage cosmetic:data Selection.Recursive append from storage player:data selected.cosmetics[{"type": "cosmetic:killer/skin"}]

function ./add_tag with storage cosmetic:data Selection.Recursive[0]
function ./add_tag:
    $tag @s add $(id)

    data remove storage cosmetic:data Selection.Recursive[0]
    execute if data storage cosmetic:data Selection.Recursive[0] run function ~/ with storage cosmetic:data Selection.Recursive[0]