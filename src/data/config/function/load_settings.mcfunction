import config:registry as registry

for option in registry.getOptions():
    execute store result score $config option run data get storage config:settings option