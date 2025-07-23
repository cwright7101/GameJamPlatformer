// bump the level
with (obj_Controller) {
    level_number += 1;
    // reposition both players before spamming new platforms:
    with (obj_Player) {
        x       = start_x;
        y       = start_y;
        hsp     = 0;
        vsp     = 0;
        can_jump= false;
    }

    // now wipe & rebuild everything for the new level
    scr_generate_level();
}
