// obj_Controller → Draw GUI
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(16, 16, "Score: " + string(global.score));

// then draw level, just below it:
draw_text(16, 48, "Level: " + string(level_number));
