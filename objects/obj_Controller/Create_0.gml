global.blaze_score     = 0;
global.glacia_score     = 0;
level_number     = 1;

// your level‑tuning parameters:
platform_count   = 6;
platform_min_w   = 128;
platform_max_w   = 256;
portal_margin    = 64;

// store player spawns if you need to reposition them:
with (obj_Player) {
    start_x = x; 
    start_y = y;
}

// === UI STATE ===
// toggle for the “How To” overlay
show_howto     = false;

// button sizing
btn_w          = 120;
btn_h          = 32;

// Reset button position (top‑right, 16px margin)
reset_btn_x    = room_width - btn_w - 16;
reset_btn_y    = 16;

// How‑To button sits just below Reset
howto_btn_x    = reset_btn_x;
howto_btn_y    = reset_btn_y + btn_h + 8;