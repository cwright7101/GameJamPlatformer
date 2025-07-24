// obj_Controller – Draw GUI Event

// 1) Draw scores & level (your original HUD)
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(16, 16, "Blaze Score: "  + string(global.blaze_score));
draw_text(16, 48, "Glacia Score: " + string(global.glacia_score));
draw_text(16, 80, "Level: "        + string(level_number));

// 2) Draw Reset button
draw_set_color(c_black);
draw_rectangle(reset_btn_x, reset_btn_y,
               reset_btn_x + btn_w, reset_btn_y + btn_h,
               false);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(reset_btn_x + btn_w/2,
          reset_btn_y + btn_h/2,
          "Reset");

// 3) Draw How‑To button
draw_set_color(c_black);
draw_rectangle(howto_btn_x, howto_btn_y,
               howto_btn_x + btn_w, howto_btn_y + btn_h,
               false);
draw_set_color(c_white);
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
    var txt =
      "How to Play:\n\n" +
      "Blaze Controls:\n" +
      "  Move: A / D\n" +
      "  Jump: W (normal)\n" +
      "  Charge Jump: S (hold & release)\n\n" +
      "Glacia Controls:\n" +
      "  Move: Left / Right arrows (<- / ->)\n" +
      "  Jump: Down arrow (normal)\n" +
      "  Charge Jump: Up arrow (hold & release)\n\n" +
      "Press R to reset level";
    draw_set_color(c_white);
    draw_text(bx + 16, by + 16, txt);
}
