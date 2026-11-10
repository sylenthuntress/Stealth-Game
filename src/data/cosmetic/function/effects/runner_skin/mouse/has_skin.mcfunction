execute unless score @s game.player.team_id matches 1 run return fail
execute if data storage player:data selected.cosmetics[{id:"cosmetic.runner_skin.field_mouse"}] run return 1
execute if data storage player:data selected.cosmetics[{id:"cosmetic.runner_skin.sewer_rat"}] run return 1

return fail