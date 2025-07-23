/// @function scr_apply_physics(inst)
/// @param inst  The instance to apply physics to
function scr_apply_physics(inst) {
    with (inst) {
        var dt    = delta_time / 1_000_000;
        var new_x = x + hsp * dt;
        var new_y = y + vsp * dt;

        // 1) Apply friction only when no input (optional)
        if (hsp == 0) {
            hsp += friction * dt;
        }

        // 2) Apply gravity
        vsp += gravity_direction * grav * dt;

        // 3) Horizontal movement + collision
        if (!place_meeting(new_x, y, obj_Ground)) {
            x = new_x;
        } else {
            // hit a vertical face of the ground → stop X
            var blocker = instance_place(new_x, y, obj_Ground);
            if (hsp > 0) {
                // moving right → snap to left side
                x = blocker.bbox_left - sprite_xoffset;
            } else if (hsp < 0) {
                // moving left → snap to right side
                x = blocker.bbox_right + sprite_xoffset;
            }
            hsp = 0;
        }

        // 4) Vertical movement + collision
        if (!place_meeting(x, new_y, obj_Ground)) {
            y = new_y;
        } else {
            // hit top/bottom face of the ground → stop Y
            var blocker = instance_place(x, new_y, obj_Ground);
            if (vsp > 0 && gravity_direction == 1) {
                // falling down onto it
                y = blocker.bbox_top - sprite_yoffset;
                can_jump = true;
            } else if (vsp < 0 && gravity_direction == -1) {
                // floating up into it
                y = blocker.bbox_bottom + sprite_yoffset;
                can_jump = true;
            }
            vsp = 0;
        }
    }
}
