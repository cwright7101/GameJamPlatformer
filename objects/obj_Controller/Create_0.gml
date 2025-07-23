global.score     = 0;
level_number     = 1;

// your level‑tuning parameters:
platform_count   = 6;
platform_min_w   = 128;
platform_max_w   = 256;
coin_density     = 0.05;
portal_margin    = 64;

// store player spawns if you need to reposition them:
with (obj_Player) {
    start_x = x; 
    start_y = y;
}