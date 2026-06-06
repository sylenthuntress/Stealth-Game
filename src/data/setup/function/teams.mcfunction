# Lobby
team add lobby {"text":"Lobby","color":"#cfdb2e"}
team add dev {"text":"Developers","color":"#ff8c18"}
team modify dev prefix [
    {
        "text":"[",
        "color":"gold",
        "bold":true
    },
    {
        "text":"Dev",
        "bold":false,
        "color": "#ff8c18"

    },
    {
        "text":"] ",
        "color":"gold",
        "bold":true
    }
]


# Killer
team add killer {"text":"Killers","color":"red"}
team modify killer color gold
team modify killer friendlyFire false
team modify killer collisionRule never
team modify killer nametagVisibility always
team modify killer seeFriendlyInvisibles true
team modify killer deathMessageVisibility never
team modify killer prefix [{"text":"[","color":"dark_gray","bold":true},{"text":"Killer","bold":false,"color":"red"},{"text":"] ","color":"dark_gray","bold":true}]

# Sneaker
team add sneaker {"text":"Mice","color":"gray"}
team modify sneaker color gray
team modify sneaker friendlyFire false
team modify sneaker collisionRule never
team modify sneaker nametagVisibility hideForOtherTeams
team modify sneaker seeFriendlyInvisibles true
team modify sneaker deathMessageVisibility never
team modify sneaker prefix {
    "text":"🐁 ",
    "bold":false,
    "color":"#8a8a8a"
}

# Spectator
team add spectator "Spectators"
team modify spectator color dark_gray
team modify spectator prefix [
    {
        "text":"[",
        "color":"dark_gray",
        "bold":true
    },
    {
        "text":"Spectating",
        "bold":false,
        "color":"#8a8a8a"
    },
    {
        "text":"] ",
        "color":"dark_gray",
        "bold":true
    }
]
