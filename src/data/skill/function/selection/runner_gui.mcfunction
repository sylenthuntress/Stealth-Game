import skill:registry as registry

data remove storage skill:selection Options
data remove storage skill:selection Recursive
data modify storage skill:selection Recursive set from storage skill:registry RunnerSkills
advancement revoke @s only skill:selection/runner_gui
tag @s add skill.selection.runner_skill

data merge storage skill:selection {"title": {"translate": "skill.selection.gui"}}

function skill:selection/make_options

function skill:selection/open_dialog with storage skill:selection
