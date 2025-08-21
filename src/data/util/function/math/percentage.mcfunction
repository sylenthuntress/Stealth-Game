# Throw error if operator/operand not present
execute unless score #OPERAND math.percentage matches -2147483648..2147483647 run say Operand for "percentage" calculation not found
execute unless score #OPERATOR math.percentage matches -2147483648..2147483647 run say Operator for "percentage" calculation not found

execute unless score #OPERAND math.percentage matches -2147483648..2147483647 run return fail
execute unless score #OPERATOR math.percentage matches -2147483648..2147483647 run return fail

# Calculations
scoreboard players operation #OPERAND math.percentage *= #CONSTANT constant.100

scoreboard players operation #OPERAND math.percentage /= #OPERATOR math.percentage
scoreboard players operation #RESULT math.result = #OPERAND math.percentage

# Reset operator/operand after calculation
scoreboard players reset #OPERAND math.percentage
scoreboard players reset #OPERATOR math.percentage

# Return result
return run scoreboard players get #RESULT math.result