/// @function scr_generate_level()
/// @description
///   Clears out old level pieces and densely populates new platforms, coins, and the exit portal.
function scr_generate_level() {
    // Ensure controller exists
    if (!instance_exists(obj_Controller)) return;
    var ctrl = instance_find(obj_Controller, 0);

    // Tuning: small platforms & gaps for high density
    var min_w   = 32;
    var max_w   = 64;
    var min_gap = 16;
    var max_gap = 32;

    // Clear out any old instances
    with (obj_Platform) instance_destroy();
    with (obj_Coin)     instance_destroy();
    with (obj_End)      instance_destroy();

    // Spawn platforms & coins
    var x_cursor = 0;
    while (x_cursor < room_width - ctrl.portal_margin) {
        // platform width & vertical position
        var pw = irandom_range(min_w, max_w);
        var py = irandom_range(room_height * 0.25, room_height * 0.75);

        // create platform and scale to 'pw' pixels
        var p = instance_create_layer(x_cursor, py, "Instances", obj_Platform);
        p.image_xscale = pw / sprite_get_width(p.sprite_index);

        // scatter coins atop this platform
        var coin_count = ceil(pw * ctrl.coin_density);
        for (var i = 0; i < coin_count; i++) {
            var cx = p.x + (i + 0.5) * (pw / coin_count);
            var cy = p.y - sprite_get_height(spr_coin) / 2 - 8;
            instance_create_layer(cx, cy, "Instances", obj_Coin);
        }

        // advance cursor by platform width + random gap
        x_cursor += pw + irandom_range(min_gap, max_gap);
    }

    // Place the exit portal at the far right
    var last_index = instance_number(obj_Platform) - 1;
    var last_py    = last_index >= 0
        ? instance_find(obj_Platform, last_index).y
        : room_height / 2;
    var py_end = clamp(last_py - 64, 64, room_height - 64);
    instance_create_layer(room_width - ctrl.portal_margin, py_end, "Instances", obj_End);
}
