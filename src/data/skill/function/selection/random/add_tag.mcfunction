$execute if entity @s[tag=$(id)] run return fail

$data modify storage skill:random args.id set value "$(id)"
$data modify storage skill:random args.desc set value "$(desc)"
$data modify storage skill:random args.icon set value "$(icon)"
$data modify storage skill:random args.atlas set value "$(atlas)"
function skill:announcement/remove_name with storage skill:random args
function ./add_name with storage skill:random args
function ./add_name:
    function skill:announcement/add_name with storage skill:random args
    $data modify storage skill:selection RoundSelections[{"uid":$(uid)}].skills[-1].random_skill set value true

$return run tag @s add $(id)