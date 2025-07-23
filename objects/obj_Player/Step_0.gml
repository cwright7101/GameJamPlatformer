/// obj_Player Step Event
show_debug_message("STEP: hsp=" + string(hsp) + " vsp=" + string(vsp));

if keyboard_check(ord("A")) { show_debug_message(" INPUT: Left"); }
if keyboard_check(ord("D")) { show_debug_message(" INPUT: Right"); }
if keyboard_check_pressed(vk_space) { show_debug_message(" INPUT: Jump"); }

// 0) Fixed‐step delta
var dt = 1 / room_speed;

// 1) Read horizontal input
hsp = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * walk_speed;

var onGround = place_meeting(x, y + sign(gravity_direction), obj_Ground);
if (keyboard_check_pressed(vk_space) && onGround) {
    vsp = -gravity_direction * jump_strength;
}

// 3) Apply gravity
vsp += gravity_direction * grav * dt;

// 4) Horizontal move + collision
var newX = x + hsp * dt;
if (!place_meeting(newX, y, obj_Ground)) {
    x = newX;
}

// 5) Vertical move + collision
var newY = y + vsp * dt;
if (!place_meeting(x, newY, obj_Ground)) {
    y = newY;
} else {
    // Landed (or hit ceiling)
    vsp = 0;
}
