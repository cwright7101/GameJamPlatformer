/// obj_Fireportal – Collision with Blaze
with (obj_Controller) {
    level_number += 1;
    with (obj_Player) {
        x       = start_x;
        y       = start_y;
        hsp     = 0;
        vsp     = 0;
        can_jump= false;
    }
    scr_generate_level();
}
