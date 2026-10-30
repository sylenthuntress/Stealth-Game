$execute if entity @s[tag=$(id)] run return fail
# Check conditions before adding tag
scoreboard players set #var var.predicate 1

execute if data storage skill:data Random.args.skill.predicate run function ./check_predicate with storage skill:data Random.args.skill
function ./check_predicate:
    $execute unless predicate $(predicate) run scoreboard players set #var var.predicate 0
execute if data storage skill:data args.skill.components."skill:team_only" run function ./check_teammates:
    scoreboard objectives add var.teammates dummy
    execute store result score @s var.teammates run data get storage skill:data Random.args.skill.components."skill:team_only"
    execute if score @s[scores={game.player.team_id=1}] var.teammates > #gamestate gamestate.runners run scoreboard players set #var var.predicate 0
    execute if score @s[scores={game.player.team_id=2}] var.teammates > #gamestate gamestate.killers run scoreboard players set #var var.predicate 0
    scoreboard objectives remove var.teammates

execute if score #var var.predicate matches 0 run return fail # Guard-return if condition fails

# Add tag if conditions pass
execute store result storage skill:data Random.args.skill.uid int 1 run scoreboard players get @s uid.player

function skill:announcement/remove_name with storage skill:data Random.args
function ./add_name with storage skill:data Random.args
function ./add_name:
    function skill:announcement/add_name with storage skill:data Random.args
    $data modify storage skill:selection RoundSelections[{"uid":$(uid)}].skills[-1].random_skill set value true

$return run tag @s add $(id)