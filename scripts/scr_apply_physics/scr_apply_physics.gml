/// scr_apply_physics()
function scr_apply_physics()
{
	/// Applies gravity and moves with collision
	vsp += gravity_direction * grav * (delta_time/1000000); // adjust for frame rate

	// Horizontal move
	x_prev = x;  
	x += hsp * (delta_time/1000000);
	if place_meeting(x, y, obj_Ground) {
	    x = x_prev;
	}

	// Vertical move
	y_prev = y;  
	y += vsp * (delta_time/1000000);
	if place_meeting(x, y, obj_Ground) {
	    // landed: reset jump
	    y = y_prev;
	    vsp = 0;
	    can_jump = true;
	} else {
	    can_jump = false;
	}
}
