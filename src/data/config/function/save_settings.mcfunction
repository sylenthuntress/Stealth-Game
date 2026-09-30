import config:registry as registry

for option in registry.getOptions():
    execute store result storage config:settings option int 1 run scoreboard players get $config option