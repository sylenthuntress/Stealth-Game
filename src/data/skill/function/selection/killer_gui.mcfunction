import skill:registry as registry

data remove storage skill:selection Options
data remove storage skill:selection Recursive
data modify storage skill:selection Recursive set from storage skill:registry KillerSkills
tag @s add skill.selection.killer_skill
function skill:selection/make_options

function skill:selection/open_dialog with storage skill:selection
