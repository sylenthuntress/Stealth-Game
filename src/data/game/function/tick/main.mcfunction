# Tick subtasks
execute if score $gamestate gamestate.round_active matches 1 run function game:gameplay/tick/main
function render:tick/main