/// @function scr_handle_input(inst)
/// @param inst  The player instance (obj_Blaze or obj_Glacia)
/// @description
///   Reads input for two characters: Blaze (A/D for left/right; W or S to jump)
///   and Glacia (←/→ for left/right; ↑ or ↓ to jump), plus R to reset.
function scr_handle_input(inst) {
    // 1) Reset on R key
    if (keyboard_check_pressed(ord("R"))) {
        inst.x         = inst.start_x;
        inst.y         = inst.start_y;
        inst.hsp       = 0;
        inst.vsp       = 0;
        inst.can_jump  = false;
        return; // skip movement/jump this frame
    }

    // 2) Determine key mappings per character
    var left_key, right_key;
    var jump_key1, jump_key2;
    if (inst.object_index == obj_Blaze) {
        left_key   = ord("A");
        right_key  = ord("D");
        jump_key1  = ord("W");
        jump_key2  = ord("S");
    } else if (inst.object_index == obj_Glacia) {
        left_key   = vk_left;
        right_key  = vk_right;
        jump_key1  = vk_up;
        jump_key2  = vk_down;
    } else {
        // fallback to Blaze keys
        left_key   = ord("A");
        right_key  = ord("D");
        jump_key1  = ord("W");
        jump_key2  = ord("S");
    }

    // 3) Horizontal movement
    var dir = keyboard_check(right_key) - keyboard_check(left_key);
    inst.hsp = dir * inst.move_speed;

    // 4) Ground check (one pixel in gravity direction)
    inst.can_jump = place_meeting(
        inst.x,
        inst.y + sign(inst.gravity_direction),
        obj_Platform
    );

    // 5) Jump if either key pressed and on ground
    if ((keyboard_check_pressed(jump_key1) || keyboard_check_pressed(jump_key2)) && inst.can_jump) {
        inst.vsp = -inst.gravity_direction * inst.jump_strength;
    }
}
