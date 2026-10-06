data remove storage skill:selection selector
execute store result storage skill:selection selector.uid int 1 run scoreboard players get @s uid.player
function skill:get_skills with storage skill:selection selector

function skill:add_tags with storage skill:selection Recursive[0]
