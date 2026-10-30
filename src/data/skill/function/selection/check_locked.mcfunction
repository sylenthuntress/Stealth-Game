function ./check_predicate with storage skill:data Selection.Recursive[0]
function ./check_predicate:
    $execute unless predicate $(predicate) run function ./lock_option
execute if score #gamestate gamestate.game_active matches 1 unless score #var var.locked matches 1 run function ./check_teammates:
    scoreboard objectives add var.teammates dummy
    execute store result score @s var.teammates run data get storage skill:data Selection.Recursive[0].components."skill:team_only"
    execute if score @s[scores={game.player.team_id=1}] var.teammates > #gamestate gamestate.runners run function ./lock_option
    execute if score @s[scores={game.player.team_id=2}] var.teammates > #gamestate gamestate.killers run function ./lock_option

    execute if data storage skill:data Selection.dialog.actions[-1].locked expand: 
        data modify storage skill:data Selection.dialog.actions[-1].tooltip set value {"translate": "skill.selection.locked", "color": "dark_gray", "bold": true, "with": [{"translate": "skill.selection.locked.team_only", "color": "white", "bold": false, "with": [{"text": "", "color": "red"}]}]}
        execute store result storage skill:data Selection.dialog.actions[-1].tooltip.with[0].with[0].teammates int 1 run scoreboard players get @s var.teammates
        data modify storage skill:data Selection.dialog.actions[-1].tooltip.with[0].with[0].text set string storage skill:data Selection.dialog.actions[-1].tooltip.with[0].with[0].teammates

    scoreboard objectives remove var.teammates

function ./lock_option:
    data modify storage skill:data Selection.dialog.actions[-1].label.color set value "dark_gray"
    data modify storage skill:data Selection.dialog.actions[-1].label.with[0].color set value "dark_gray"
    data modify storage skill:data Selection.dialog.actions[-1].label.strikethrough set value true
    data modify storage skill:data Selection.dialog.actions[-1].action.command set value "trigger skill.selection set -1" 
    data modify storage skill:data Selection.dialog.actions[-1].locked set value true
    scoreboard players set #var var.locked 1