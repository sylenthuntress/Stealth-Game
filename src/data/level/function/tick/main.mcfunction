# Tick subtasks
function level:segment/hazard/tick
execute if score #gamestate gamestate.game_active matches 1 as @e[tag=segment_entity.ticking] at @s run function #level:segment/tick