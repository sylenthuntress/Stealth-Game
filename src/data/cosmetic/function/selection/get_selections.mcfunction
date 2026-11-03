# Parameters: {"uid": int}
data modify storage cosmetic:temp Selections set value {}
data modify storage cosmetic:temp Selections.identifiers set value []
data modify storage cosmetic:temp Selections.verbose set value []

$data modify storage cosmetic:temp Selections.identifiers append from storage cosmetic:data Selection.players[{"uid": $(uid)}].cosmetics[]
execute unless data storage cosmetic:temp Selections.identifiers[0] run data modify storage cosmetic:temp Selections.identifiers append from storage cosmetic:data Registry[{"components":{"cosmetic:default": true}}]

data modify storage cosmetic:temp Selections.recursive set from storage cosmetic:temp Selections.identifiers
function ./from_registry with storage cosmetic:temp Selections.recursive[0]
function ./from_registry:
    $data modify storage cosmetic:temp Selections.verbose append from storage cosmetic:data Registry[{"id": $(id)}]
    data remove storage cosmetic:temp Selections.recursive[0]
    execute if data storage cosmetic:temp Selections.recursive[0] run function ~/ with storage cosmetic:temp Selections.recursive[0]