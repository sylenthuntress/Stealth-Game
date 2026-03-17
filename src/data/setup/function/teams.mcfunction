# Lobby
team add lobby "Lobby"

# Killer
team add killer "Killer"
team modify killer color gold
team modify killer friendlyFire false
team modify killer collisionRule never
team modify killer nametagVisibility always
team modify killer seeFriendlyInvisibles true
team modify killer deathMessageVisibility never
team modify killer displayName {"text":"Killers","color":"red"}
team modify killer prefix [{"text":"[","color":"dark_gray","bold":true},{"text":"Killer","bold":false,"color":"red"},{"text":"] ","color":"dark_gray","bold":true}]

# Sneaker
team add sneaker "Sneaker"
team modify sneaker color gray
team modify sneaker friendlyFire false
team modify sneaker collisionRule never
team modify sneaker nametagVisibility hideForOtherTeams
team modify sneaker seeFriendlyInvisibles true
team modify sneaker deathMessageVisibility never
team modify sneaker displayName {"text":"Mice","color":"gray"}
team modify sneaker prefix {
    "text":"🐁 ",
    "bold":false,
    "color":"#8a8a8a"
}

# Spectator
team add spectator "Spectator"
team modify spectator color dark_gray
team modify spectator prefix [{"text":"[","color":"dark_gray","bold":true},{"text":"Spectating","bold":false,"color":"#8a8a8a"},{"text":"] ","color":"dark_gray","bold":true}]
