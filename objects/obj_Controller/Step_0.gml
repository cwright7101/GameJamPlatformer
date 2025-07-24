var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

if (mouse_check_button_pressed(mb_left)) {
    // Reset button?
    if (mx > reset_btn_x && mx < reset_btn_x + btn_w
     && my > reset_btn_y && my < reset_btn_y + btn_h) {
        room_restart();
    }
    // How‑To toggle?
    else if (mx > howto_btn_x && mx < howto_btn_x + btn_w
          && my > howto_btn_y && my < howto_btn_y + btn_h) {
        show_howto = !show_howto;
    }
}
