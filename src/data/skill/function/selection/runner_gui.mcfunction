import skill:registry as registry

data remove storage skill:selection Options
data remove storage skill:registry Recursive
data modify storage skill:registry Recursive set from storage skill:registry RunnerSkills
tag @s add skill.selection.runner_skill
function skill:selection/make_options

function skill:selection/open_dialog with storage skill:selection
