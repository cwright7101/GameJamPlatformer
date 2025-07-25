var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// START‑SCREEN INPUT
if (!game_started) {
    if (mouse_check_button_pressed(mb_left)) {
        // If overlay is up, only the Close button works:
        if (show_howto) {
            if (mx > close_btn_x && mx < close_btn_x + close_btn_w
             && my > close_btn_y && my < close_btn_y + close_btn_h) {
                show_howto = false;
            }
        }
        else {
            // 1-Player
            if (mx > start_btn_x && mx < start_btn_x + btn_w
             && my > start_btn_y && my < start_btn_y + btn_h) {
                player_count = 1;
                game_started = true;
                scr_generate_level();
				// remove Glacia, leave only Blaze
	            with (obj_Glacia) {
	                instance_destroy();
	            }
				with (obj_Iceportal) {
	                instance_destroy();
	            }
				
            }
            // 2-Players
            else if (mx > two_btn_x && mx < two_btn_x + btn_w
                  && my > two_btn_y && my < two_btn_y + btn_h) {
                player_count = 2;
                game_started = true;
                scr_generate_level();
            }
            // How-To (start screen)
            else if (mx > start_howto_x && mx < start_howto_x + btn_w
                  && my > start_howto_y && my < start_howto_y + btn_h) {
                show_howto = true;
            }
        }
    }
    return;
}


if (mouse_check_button_pressed(mb_left)) {
    // Reset button?
    if (mx > reset_btn_x && mx < reset_btn_x + btn_w
	 && my > reset_btn_y && my < reset_btn_y + btn_h) {
	    // reset scores
	    global.blaze_score  = 0;
	    global.glacia_score = 0;
	    // optionally reset level number too:
	    level_number = 1;
		game_started = false;
	    room_restart();
	}
	// How‑To toggle?
    else if (mx > howto_btn_x && mx < howto_btn_x + btn_w
          && my > howto_btn_y && my < howto_btn_y + btn_h) {
        show_howto = !show_howto;
    }
}
