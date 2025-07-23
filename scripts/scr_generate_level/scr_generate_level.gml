/// @function scr_generate_level()
/// @description
///   Clears old platforms, coins, and portals, then generates a new level layout
///   densely populated with small platforms but with at most two coins per level.
///   Places both an ice portal and a fire portal at the end within reach.
function scr_generate_level() {
    // Ensure controller exists
    if (!instance_exists(obj_Controller)) return;
    var ctrl = instance_find(obj_Controller, 0);

    // Tuning: small platforms & gaps for high density
    var min_w     = 32;
    var max_w     = 64;
    var min_gap   = 16;
    var max_gap   = 32;

    // Clear out any old instances
    with (obj_Platform)      instance_destroy();
    with (obj_Coin)          instance_destroy();
    with (obj_Iceportal)     instance_destroy();
    with (obj_Fireportal)    instance_destroy();

    // Limit to two coins per level
    var coins_placed = 0;
    var max_coins    = 2;

    // Spawn platforms and up to max_coins coins
    var x_cursor = 0;
    while (x_cursor < room_width - ctrl.portal_margin) {
        // choose platform width & vertical position
        var pw = irandom_range(min_w, max_w);
        var py = irandom_range(room_height * 0.25, room_height * 0.75);

        // create platform and scale to 'pw' pixels
        var p = instance_create_layer(x_cursor, py, "Instances", obj_Platform);
        p.image_xscale = pw / sprite_get_width(p.sprite_index);

        // place a coin if we haven't reached the max
        if (coins_placed < max_coins) {
            var cx = p.x + pw * 0.5;
            var cy = p.y - sprite_get_height(spr_coin) * 0.5 - 8;
            instance_create_layer(cx, cy, "Instances", obj_Coin);
            coins_placed += 1;
        }

        // advance cursor by platform width + random gap
        x_cursor += pw + irandom_range(min_gap, max_gap);
    }

    // Place the exit portals at the far right
    var last_index = instance_number(obj_Platform) - 1;
    var last_py    = last_index >= 0
        ? instance_find(obj_Platform, last_index).y
        : room_height * 0.5;
    var py_end = clamp(last_py - 64, 64, room_height - 64);

    // base X position for portals
    var x_base = room_width - ctrl.portal_margin;
    // horizontal padding between portals
    var pad    = 32;

    // create ice portal to the left of base
    instance_create_layer(x_base - pad, py_end, "Instances", obj_Iceportal);
    // create fire portal to the right of base
    instance_create_layer(x_base + pad, py_end, "Instances", obj_Fireportal);
}