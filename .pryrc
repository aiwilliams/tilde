Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'f', 'finish'

EE.enabled = true
EE.intercept(ArgumentError)
EE.intercept(RuntimeError)
EE.intercept(NoMethodError)

