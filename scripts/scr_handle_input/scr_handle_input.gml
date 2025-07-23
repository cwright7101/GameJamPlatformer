/// @function scr_handle_input(inst)
/// @param inst  The instance to apply input to
function scr_handle_input(inst) {
    with (inst) {
		if (keyboard_check_pressed(ord("R"))) {
            x   = start_x;
            y   = start_y;
            hsp = 0;
            vsp = 0;
            can_jump = false;
            return;  // skip all the other input this frame
        }
        // 1) Horizontal movement (arrows + A/D)
        var dir = (keyboard_check(vk_right) || keyboard_check(ord("D")))
                - (keyboard_check(vk_left ) || keyboard_check(ord("A")));
        hsp = dir * move_speed;

        // 2) Can we jump?  Test one pixel *in* our gravity direction
        can_jump = place_meeting(x, y + sign(gravity_direction), obj_Ground);

        // 3) Jump opposite to gravity
        if (keyboard_check_pressed(vk_space) && can_jump) {
            vsp = -gravity_direction * jump_strength;
        }
    }
}
