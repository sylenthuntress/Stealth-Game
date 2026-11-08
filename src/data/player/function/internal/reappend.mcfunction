# Parameters: {uuid: UUID}
$execute unless data storage player:data players[{"uuid": $(uuid)}] run return run data modify storage player:data players append value {uuid: $(uuid)}

$data modify storage player:data players append from storage player:data players[{"uid": $(uuid)}]
$data modify storage player:data players[{"uuid": $(uuid)}].old set value true
data remove storage player:data players[-1].old
data remove storage player:data players[{old:true}]