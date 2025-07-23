function scr_apply_physics(inst) {
    with (inst) {
        var dt    = delta_time / 1_000_000;
        var dir   = sign(hsp);          // +1, –1 or 0
        var new_x = x + hsp * dt;
        var new_y = y + vsp * dt;

        // only slow down when no input
        if (dir == 0) {
            hsp += friction * dt;
        }

        // gravity
        vsp += gravity_direction * grav * dt;

        // move
        x = new_x;
        y = new_y;
    }
}
