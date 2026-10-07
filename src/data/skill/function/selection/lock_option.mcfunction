execute if data storage skill:selection Recursive[0].is_random run return fail
$execute unless score @s[tag=skill.selection.runner_skill] skill.slots.runner.random_selected matches 1 if data storage skill:selection selections[{"uid": $(uid)}].skills[{"id": "$(id)"}] run return fail
$execute unless score @s[tag=skill.selection.killer_skill] skill.slots.killer.random_selected matches 1 if data storage skill:selection selections[{"uid": $(uid)}].skills[{"id": "$(id)"}] run return fail
$execute unless score @s[tag=skill.selection.weapon] skill.slots.weapon.random_selected matches 1 if data storage skill:selection selections[{"uid": $(uid)}].skills[{"id": "$(id)"}] run return fail

data modify storage skill:selection Options[-1].label.color set value "dark_gray"
data modify storage skill:selection Options[-1].label.with[0].color set value "dark_gray"
data modify storage skill:selection Options[-1].label.strikethrough set value true
data modify storage skill:selection Options[-1].action.command set value "trigger skill.selection set -1" 