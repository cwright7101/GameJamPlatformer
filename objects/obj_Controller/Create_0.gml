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





// start‑screen state
game_started   = false;
player_count   = 1;

// start‑screen button positions
start_btn_x    = room_width * 0.25 - btn_w/2;
start_btn_y    = room_height * 0.50 - btn_h/2;

two_btn_x      = room_width * 0.75 - btn_w/2;
two_btn_y      = start_btn_y;

start_howto_x  = room_width * 0.50 - btn_w/2;
start_howto_y  = start_btn_y + btn_h + 16;

// Overlay window dimensions (for both start & in-game How-To)
overlay_w     = room_width  * 0.6;
overlay_h     = room_height * 0.6;
overlay_x     = (room_width  - overlay_w) / 2;
overlay_y     = (room_height - overlay_h) / 2;

// Close-button inside the overlay
close_btn_w   = 80;
close_btn_h   = 32;
close_btn_x   = overlay_x + overlay_w - close_btn_w - 16;
close_btn_y   = overlay_y + 16;

