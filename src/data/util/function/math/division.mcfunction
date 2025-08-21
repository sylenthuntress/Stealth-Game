# Throw error if operator/operand not present
execute unless score #OPERAND math.division matches -2147483648..2147483647 run say Operand for "division" calculation not found
execute unless score #OPERATOR math.division matches -2147483648..2147483647 run say Operator for "division" calculation not found

execute unless score #OPERAND math.division matches -2147483648..2147483647 run return fail
execute unless score #OPERATOR math.division matches -2147483648..2147483647 run return fail

# Calculations
scoreboard players operation #OPERAND math.division /= #OPERATOR math.division
scoreboard players operation #RESULT math.result = #OPERAND math.division

# Reset operator/operand after calculation
scoreboard players reset #OPERAND math.division
scoreboard players reset #OPERATOR math.division

# Return result
return run scoreboard players get #RESULT math.result