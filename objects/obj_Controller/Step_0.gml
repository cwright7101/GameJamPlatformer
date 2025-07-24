var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

if (mouse_check_button_pressed(mb_left)) {
    // Reset button?
    if (mx > reset_btn_x && mx < reset_btn_x + btn_w
	 && my > reset_btn_y && my < reset_btn_y + btn_h) {
	    // reset scores
	    global.blaze_score  = 0;
	    global.glacia_score = 0;
	    // optionally reset level number too:
	    // level_number = 1;
	    room_restart();
	}
}
