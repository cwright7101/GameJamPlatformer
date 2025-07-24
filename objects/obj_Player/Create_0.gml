// obj_Player – Create Event
hsp = 0;
vsp = 0;

grav              = 980;
gravity_direction = 1;
friction          = -600;
move_speed        = 300;

// jumping
jump_strength = 550;
can_jump      = false;

start_x = x;
start_y = y;

// charge jump configuration
jump_charge      = 1;    // current multiplier
min_jump_charge  = .5;    // no weaker than normal
max_jump_charge  = 1.25;    // up to × power
charge_rate      = 1;    // how much charge per second
