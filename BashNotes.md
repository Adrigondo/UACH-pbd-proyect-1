
### : at start `":at"`
`:` at the start is used to manage error result of a wrong flag,
it will be redirected to the case `\?`.

### : after a letter `:a:t`
`:` after a letter is used when the flag is expected to almost take an argument. If the argument was not provided, the case to be executed will be `:`.

### $OPTARG
It returns the name of the flag in the current iteration, each iteration checks the provided arguments. 