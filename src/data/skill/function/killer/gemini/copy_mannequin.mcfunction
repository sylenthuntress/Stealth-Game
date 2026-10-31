$summon mannequin ~ ~.0001 ~ {Tags:["skill.killer.gemini.clone"],profile:$(profile),Rotation:$(Rotation),CustomName:$(CustomName),CustomNameVisible:$(CustomNameVisible),hide_description:$(hide_description),pose:$(pose)}
execute positioned ~ ~.0001 ~ run team join killer @n[type=mannequin,tag=skill.killer.gemini.clone]
teleport @n[type=mannequin,tag=skill.killer.gemini.clone] ~ ~ ~