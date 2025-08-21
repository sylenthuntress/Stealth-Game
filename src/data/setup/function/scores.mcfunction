# Config
scoreboard objectives add config.loaded_defaults dummy

scoreboard objectives add config.team_selection dummy
scoreboard objectives add config.gamemode dummy
scoreboard objectives add config.seeker_ratio dummy
scoreboard objectives add config.round_timer dummy

execute if score $config config.loaded_defaults matches 0 run function config:load_defaults
scoreboard players set $config config.loaded_defaults 1

# Gamestate
scoreboard objectives add gamestate.game_active dummy
scoreboard objectives add gamestate.round_active dummy
scoreboard objectives add gamestate.round_count dummy

# Game
scoreboard objectives add game.player.team_id dummy
scoreboard objectives add game.player.health dummy

# Math
scoreboard objectives add constant.100 dummy
scoreboard players set #CONSTANT constant.100 100

scoreboard objectives add math.division dummy
scoreboard objectives add math.percentage dummy
scoreboard objectives add math.result dummy

# Time
scoreboard objectives add time.round_timer dummy