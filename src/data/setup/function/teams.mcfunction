# Lobby
team add lobby "Lobby"

# Seeker
team add seeker "Seeker"
team modify seeker color gold
team modify seeker friendlyFire false
team modify seeker collisionRule never
team modify seeker nametagVisibility always
team modify seeker seeFriendlyInvisibles true
team modify seeker deathMessageVisibility never
team modify seeker displayName {"text":"Seekers","color":"red"}
team modify seeker prefix [{"text":"[","color":"dark_gray","bold":true},{"text":"Seeker","bold":false,"color":"red"},{"text":"] ","color":"dark_gray","bold":true}]

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
