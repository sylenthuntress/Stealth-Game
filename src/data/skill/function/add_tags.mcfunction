# Check conditions before adding tag
scoreboard objectives add var.predicate dummy
scoreboard players set #var var.predicate 1

function ./check_predicate with storage skill:data Selection.Recursive[0]
function ./check_predicate:
    $execute unless predicate $(predicate) run scoreboard players set #var var.predicate 0
execute if data storage skill:data Selection.Recursive[0].components."skill:team_only" run function ./check_teammates:
    scoreboard objectives add var.teammates dummy
    execute store result score @s var.teammates run data get storage skill:data Selection.Recursive[0].components."skill:team_only"
    execute if score @s[scores={game.player.team_id=1}] var.teammates > #gamestate gamestate.runners run scoreboard players set #var var.predicate 0
    execute if score @s[scores={game.player.team_id=2}] var.teammates > #gamestate gamestate.killers run scoreboard players set #var var.predicate 0
    scoreboard objectives remove var.teammates

execute if score #var var.predicate matches 0 expand: 
    data remove storage skill:data Selection.Recursive[0]
    return run scoreboard objectives remove var.predicate # Guard-return if condition fails
scoreboard objectives remove var.predicate

# Add tag if conditions pass
$tag @s add $(id)

data modify storage skill:data Selection.selector.id set from storage skill:data Selection.Recursive[0].id
function ./announcement/remove_name with storage skill:data Selection.selector 

data modify storage skill:data Selection.selector.skill set from storage skill:data Selection.Recursive[0]
function ./announcement/add_name with storage skill:data Selection.selector

data remove storage skill:data Selection.Recursive[0]
execute if data storage skill:data Selection.Recursive[0] run function ~/ with storage skill:data Selection.Recursive[0]