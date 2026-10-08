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
team modify killer prefix {
    "text":"🔪 ",
    "bold":true,
    "color":"#712525"
}

# Runner
team add runner {"text":"Mice","color":"gray"}
team modify runner color gray
team modify runner friendlyFire false
team modify runner collisionRule never
team modify runner nametagVisibility hideForOtherTeams
team modify runner seeFriendlyInvisibles true
team modify runner deathMessageVisibility never
team modify runner prefix {
    "text":"🐁 ",
    "bold":true,
    "color":"#626161"
}

# Dead
team add dead "Dead"
team modify dead color dark_gray
team modify dead prefix {
    "text":"☠ ",
    "bold":false,
    "color":"#bbb5b5"
}

# Finished
team add finished "Finish"
team modify finished color gold
team modify finished prefix {
    "text":"🏆 ",
    "bold":false,
    "color":"#626161"
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

