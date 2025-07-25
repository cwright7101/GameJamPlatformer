// obj_Controller – Draw GUI Event
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var txt =
      "How to Play:\n\n" +
	  "You score points by collecting coins.\n" +
	  "You need to get to the portals to get to the next level.\n" +
      "Blaze Controls:\n" +
      "  Move: A / D\n" +
      "  Jump: W (normal)\n" +
      "  Charge Jump: S (hold & release)\n\n" +
      "Glacia Controls:\n" +
      "  Move: Left / Right arrows (<- / ->)\n" +
      "  Jump: Down arrow (normal)\n" +
      "  Charge Jump: Up arrow (hold & release)\n\n" +
      "Press R to reset level";

		  
// START‑SCREEN DRAW
if (!game_started) {
    // dim background
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);

    // title
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text(room_width/2, 32, "My Platformer");

    // --- hover checks ---
    var over1  = mx > start_btn_x  && mx < start_btn_x + btn_w
               && my > start_btn_y  && my < start_btn_y + btn_h;
    var over2  = mx > two_btn_x    && mx < two_btn_x   + btn_w
               && my > two_btn_y    && my < two_btn_y   + btn_h;
    var overHT = mx > start_howto_x && mx < start_howto_x + btn_w
               && my > start_howto_y && my < start_howto_y + btn_h;

    // 1‑Player button
    draw_set_color(over1 ? c_red : c_black);
    draw_rectangle(start_btn_x, start_btn_y,
                   start_btn_x + btn_w, start_btn_y + btn_h,
                   false);
    draw_set_color(over1 ? c_black : c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(start_btn_x + btn_w/2,
              start_btn_y + btn_h/2,
              "1 Player");

    // 2‑Players button
    draw_set_color(over2 ? c_red : c_black);
    draw_rectangle(two_btn_x, two_btn_y,
                   two_btn_x + btn_w, two_btn_y + btn_h,
                   false);
    draw_set_color(over2 ? c_black : c_white);
    draw_text(two_btn_x + btn_w/2,
              two_btn_y + btn_h/2,
              "2 Players");

    // How‑To button (start screen)
    draw_set_color(overHT ? c_red : c_black);
    draw_rectangle(start_howto_x, start_howto_y,
                   start_howto_x + btn_w, start_howto_y + btn_h,
                   false);
    draw_set_color(overHT ? c_black : c_white);
    draw_text(start_howto_x + btn_w/2,
              start_howto_y + btn_h/2,
              "How To");

    // overlay if they opened How‑To
    if (show_howto) {
        // overlay dimensions
        var bw = room_width  * 0.6;
        var bh = room_height * 0.6;
        var bx = (room_width  - bw) / 2;
        var by = (room_height - bh) / 2;

        // background box
        draw_set_color(c_black);
        draw_rectangle(bx, by, bx + bw, by + bh, false);

        // instructions text
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_text(bx + 16, by + 16, txt);

        // Close button hover test
        var overClose = mx > close_btn_x && mx < close_btn_x + close_btn_w
                     && my > close_btn_y && my < close_btn_y + close_btn_h;

        draw_set_color(overClose ? c_red : c_black);
        draw_rectangle(close_btn_x, close_btn_y,
                       close_btn_x + close_btn_w,
                       close_btn_y + close_btn_h,
                       false);
        draw_set_color(overClose ? c_black : c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(close_btn_x + close_btn_w/2,
                  close_btn_y + close_btn_h/2,
                  "Close");
    }

    return; // skip in‑game HUD until game_started == true
}



// 1) Draw scores & level (your original HUD)
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(16, 16, "Level: "        + string(level_number));
draw_text(16, 48, "Blaze Score: "  + string(global.blaze_score));
if(player_count > 1) {
	draw_text(16, 80, "Glacia Score: " + string(global.glacia_score));
}

// --- hover tests for in‑game buttons ---
var overReset = (mx > reset_btn_x 
              && mx < reset_btn_x + btn_w
              && my > reset_btn_y 
              && my < reset_btn_y + btn_h);

var overHowTo = (mx > howto_btn_x 
              && mx < howto_btn_x + btn_w
              && my > howto_btn_y 
              && my < howto_btn_y + btn_h);

// 2) Draw Reset button
draw_set_color(overReset ? c_red : c_black);
draw_rectangle(reset_btn_x, reset_btn_y,
               reset_btn_x + btn_w, reset_btn_y + btn_h,
               false);
draw_set_color(overReset ? c_black : c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(reset_btn_x + btn_w/2,
          reset_btn_y + btn_h/2,
          "Reset");

// 3) Draw How‑To button
draw_set_color(overHowTo ? c_red : c_black);
draw_rectangle(howto_btn_x, howto_btn_y,
               howto_btn_x + btn_w, howto_btn_y + btn_h,
               false);
draw_set_color(overHowTo ? c_black : c_white);
draw_text(howto_btn_x + btn_w/2,
          howto_btn_y + btn_h/2,
          "How To");

// 4) If toggled, overlay instructions
if (show_howto) {
    var bw = room_width  * 0.6;
    var bh = room_height * 0.6;
    var bx = (room_width  - bw) / 2;
    var by = (room_height - bh) / 2;

    // panel border
    draw_set_color(c_black);
    draw_rectangle(bx, by, bx + bw, by + bh, false);

    // instructions text
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    draw_set_color(c_white);
    draw_text(bx + 16, by + 16, txt);
}


