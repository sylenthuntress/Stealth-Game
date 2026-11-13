# Parameters: {uuid: UUID}
execute unless data storage player:data players run function ./init

$execute unless data storage player:data players[{"uuid": $(UUID)}] run function player:internal/append
$execute store result score @s uid run data get storage player:data players[{"uuid": $(UUID)}].uid