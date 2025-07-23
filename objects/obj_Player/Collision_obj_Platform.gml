// Only react if you’re moving into the ground…
if ((vsp >  0 && gravity_direction ==  1)  // falling down
 || (vsp <  0 && gravity_direction == -1)) // floating up
{
    // stop vertical motion
    vsp = 0;

    // snap flush
    if (gravity_direction == 1) {
        y = other.bbox_top - sprite_yoffset;
    } else {
        y = other.bbox_bottom + sprite_yoffset;
    }

    can_jump = true;
}
