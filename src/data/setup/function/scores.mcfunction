import config:registry as registry
# Config
scoreboard objectives add config.loaded_defaults dummy

for option in registry.getOptions():
    scoreboard objectives add option trigger

execute if score $config config.loaded_defaults matches 0 run function config:load_defaults:
    for option in registry.getOptions():
        default = registry.getDefault(option)
        scoreboard players set $config option default
execute if score $config config.loaded_defaults matches 0 run function setup:registry
scoreboard players set $config config.loaded_defaults 1

# Id
scoreboard objectives add uid.index dummy
scoreboard players set $uid.index uid.index 0

scoreboard objectives add uid.player dummy
scoreboard objectives add uid.entity dummy

# Data
scoreboard objectives add data.player.health health
scoreboard objectives add data.player.damage_taken minecraft.custom:minecraft.damage_taken
scoreboard objectives add data.player.damage_dealt minecraft.custom:minecraft.damage_dealt

# Hazard
scoreboard objectives add hazard.dripleaf_launcher.timer dummy

# Gamestate
scoreboard objectives add gamestate.game_active dummy
scoreboard objectives add gamestate.round_active dummy
scoreboard objectives add gamestate.round_count dummy
scoreboard objectives add gamestate.round_total dummy
scoreboard objectives add gamestate.runners dummy
scoreboard objectives add gamestate.band_progression dummy

# Game
scoreboard objectives add game.player.team_id dummy
scoreboard objectives add game.player.prev_damage dummy
scoreboard objectives add game.player.damage dummy
scoreboard objectives add game.player.injury dummy
scoreboard objectives add game.player.heal_amount dummy
scoreboard objectives add game.player.dance_state dummy
scoreboard objectives add game.player.band_progression dummy
scoreboard objectives add game.player.target_band dummy
scoreboard objectives add game.player.due_points dummy
scoreboard objectives add game.player.points dummy
scoreboard objectives add game.player.points_split dummy
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

# Lobby
scoreboard objectives add lobby.ready dummy

# Math
scoreboard objectives add math.const dummy
scoreboard players set $100 math.const 100
scoreboard players set $20 math.const 20
scoreboard players set $4 math.const 4
scoreboard players set $3 math.const 3
scoreboard players set $2 math.const 2

scoreboard objectives add math.division dummy
scoreboard objectives add math.percentage dummy
scoreboard objectives add math.result dummy

# Skill
scoreboard objectives add skill.slots.runner.occupied dummy
scoreboard objectives add skill.slots.runner.random_selected dummy
scoreboard objectives add skill.slots.killer.occupied dummy
scoreboard objectives add skill.slots.killer.random_selected dummy
scoreboard objectives add skill.slots.weapon.occupied dummy
scoreboard objectives add skill.slots.weapon.random_selected dummy

scoreboard objectives add skill.is_random.runner dummy
scoreboard objectives add skill.is_random.killer dummy
scoreboard objectives add skill.is_random.weapon dummy

scoreboard objectives add skill.selection trigger
scoreboard objectives add skill.random_selection trigger
scoreboard objectives add skill.switch_selection trigger
scoreboard objectives add skill.close_selection trigger
scoreboard objectives add skill.current_slot trigger

scoreboard objectives add skill.runner.warper.warp_spot dummy
scoreboard objectives add skill.runner.warper.count dummy
scoreboard objectives add skill.runner.warper.cooldown dummy
scoreboard objectives add skill.runner.alchemist.count dummy
scoreboard objectives add skill.runner.alchemist.cooldown dummy
scoreboard objectives add skill.runner.medic.revive_timer dummy
scoreboard objectives add skill.runner.medic.revive_uid dummy
scoreboard objectives add skill.runner.medic.count dummy
scoreboard objectives add skill.runner.medic.uses dummy
scoreboard objectives add skill.runner.medic.heartbeat dummy
scoreboard objectives add skill.killer.athlete.dash_timer dummy
scoreboard objectives add skill.killer.athlete.cooldown dummy
scoreboard objectives add skill.killer.locator.cooldown dummy
scoreboard objectives add skill.killer.locator.tracking_uid dummy
scoreboard objectives add skill.killer.locator.tracking_timer dummy
scoreboard objectives add skill.killer.specter.cooldown dummy
scoreboard objectives add skill.killer.gemini.hide_teleport dummy
scoreboard objectives add skill.killer.gemini.clone.health dummy
scoreboard objectives add skill.killer.gemini.clone.curr_hp dummy
scoreboard objectives add skill.killer.gemini.clone.prev_hp dummy
scoreboard objectives add skill.weapon.trident.charge_time dummy
scoreboard objectives add skill.weapon.trident.motion.x dummy
scoreboard objectives add skill.weapon.trident.motion.y dummy
scoreboard objectives add skill.weapon.trident.motion.z dummy
scoreboard objectives add skill.weapon.foreseer.charge_time dummy
scoreboard objectives add skill.weapon.foreseer.cooldown dummy
scoreboard objectives add skill.weapon.foreseer.motion.x dummy
scoreboard objectives add skill.weapon.foreseer.motion.y dummy
scoreboard objectives add skill.weapon.foreseer.motion.z dummy

# Time
scoreboard objectives add time.display_sec dummy
scoreboard objectives add time.start_timer dummy
scoreboard objectives add time.start_sequence dummy
scoreboard objectives add time.round_timer dummy
scoreboard objectives add time.player.corpse_age dummy
scoreboard objectives add time.player.dance_timer dummy
scoreboard objectives add time.player.heal_timer dummy
scoreboard objectives add time.player.hide_timer dummy
scoreboard objectives add time.player.stun_timer dummy
scoreboard objectives add time.player.dash_cooldown dummy
scoreboard objectives add time.player.dash_timer dummy
scoreboard objectives add time.player.assist_timer dummy
scoreboard objectives add time.round_cooldown dummy

# Animations
scoreboard objectives add animations.sidebar.name dummy