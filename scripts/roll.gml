//takes up to 10 integer weights of options, 
// returns a number from 0-9 meaning the option randomly rolled

// options do not have to add up to 1, it will be scaled accordingly
var sum = 0;
for (var i = 0; i < argument_count; i++) {
    sum += argument[i];
}

var roll_value = irandom(sum-1);
var choice_chosen = 0;
roll_value -= argument[choice_chosen];
while (roll_value >= 0) {
    roll_value -= argument[++choice_chosen];
}
return choice_chosen;

