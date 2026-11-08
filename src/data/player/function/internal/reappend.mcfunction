# Parameters: {uid: int}
$execute unless data storage player:data players[{"uid": $(uid)}] run return run function player:internal/append

$data modify storage player:data players append from storage player:data players[{"uid": $(uid)}]
$data modify storage player:data players[{"uid": $(uid)}].old set value true
data remove storage player:data players[-1].old
data remove storage player:data players[{old:true}]