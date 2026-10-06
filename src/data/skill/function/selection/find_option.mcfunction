$execute if entity @s[tag=skill.selection.runner_skill] run data modify storage skill:selection Selection set from storage skill:registry RunnerSkills[{"numid":$(Selection)}].id
$execute if entity @s[tag=skill.selection.killer_skill] run data modify storage skill:selection Selection set from storage skill:registry KillerSkills[{"numid":$(Selection)}].id
$execute if entity @s[tag=skill.selection.weapon] run data modify storage skill:selection Selection set from storage skill:registry WeaponRegistry[{"numid":$(Selection)}].id
function skill:selection/apply_option with storage skill:selection