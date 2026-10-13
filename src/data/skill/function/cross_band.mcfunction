import skill:registry as registry

for function in registry.getFunctions():
    execute if entity @s[tag=function.tag] run function (function.path + "cross_band")