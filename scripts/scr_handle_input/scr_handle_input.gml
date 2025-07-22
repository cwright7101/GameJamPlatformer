/// scr_handle_input()
/// Reads keyboard and sets hsp/jump flag
var dir = 0;
if keyboard_check(ord("A")) { dir -= 1; }
if keyboard_check(ord("D")) { dir += 1; }
hsp = dir * walk_speed;

// Jump key
if keyboard_check_pressed(vk_space) && can_jump {
    vsp = -gravity_direction * jump_strength;
}
