import config:registry as registry
# Config
scoreboard objectives add config.loaded_defaults dummy

for option in registry.getOptions():
    scoreboard objectives add option dummy

execute if score $config config.loaded_defaults matches 0 run function config:load_defaults:
    for option in registry.getOptions():
        default = registry.getDefault(option)
        scoreboard players set $config option default
execute if score $config config.loaded_defaults matches 0 run function setup:registry
scoreboard players set $config config.loaded_defaults 1

# Id
scoreboard objectives add uid.player dummy
scoreboard objectives add uid.index dummy

# Data
scoreboard objectives add data.player.health health

# Gamestate
scoreboard objectives add gamestate.game_active dummy
scoreboard objectives add gamestate.round_active dummy
scoreboard objectives add gamestate.round_count dummy
scoreboard objectives add gamestate.round_total dummy
scoreboard objectives add gamestate.band_progression dummy

# Game
scoreboard objectives add game.player.team_id dummy
scoreboard objectives add game.player.damage dummy
scoreboard objectives add game.player.band_progression dummy
scoreboard objectives add game.player.points dummy
scoreboard objectives modify game.player.points displayname {
    "translate":"game.player.points"
}
scoreboard players set $scoredisplay game.player.points -999
scoreboard players display numberformat $scoredisplay game.player.points blank
scoreboard players display name $scoredisplay game.player.points {
    "text": "---------------------",
    "color": "gray",
    "bold": true
}

# Generation
scoreboard objectives add segments.elapsed dummy
scoreboard objectives add segments.remaining dummy
scoreboard objectives add segments.remaining_small dummy
scoreboard objectives add segments.remaining_med dummy
scoreboard objectives add segments.remaining_large dummy

# Math
scoreboard objectives add constant.100 dummy
scoreboard players set #CONSTANT constant.100 100

scoreboard objectives add math.division dummy
scoreboard objectives add math.percentage dummy
scoreboard objectives add math.result dummy

# Time
scoreboard objectives add time.start_timer dummy
scoreboard objectives add time.round_timer dummy
scoreboard objectives add time.round_cooldown dummy

# Animations
scoreboard objectives add animations.sidebar.name dummy