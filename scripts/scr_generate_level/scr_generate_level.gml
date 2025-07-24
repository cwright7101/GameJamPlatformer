/// @function scr_generate_level()
/// @description
///   Clears old platforms, coins, and portals, then generates a new level layout
///   densely populated with small platforms and places exactly two coins:
///   one atop one platform and one beneath another; ensures no coins spawn
///   on the far-left spawn platform or near the portal area.
function scr_generate_level() {
    // Ensure controller exists
    if (!instance_exists(obj_Controller)) return;
    var ctrl = instance_find(obj_Controller, 0);

    // Configuration
    var min_w          = 48;
    var max_w          = 86;
    var min_gap        = 16;
    var max_gap        = 32;
    var max_coins      = 2;
    var exclude_buffer = 48; // pixels around portal X to avoid coin placement
    var portal_x       = room_width - ctrl.portal_margin;

    // Clear old instances
    with (obj_Platform)   instance_destroy();
    with (obj_Coin)       instance_destroy();
    with (obj_Iceportal)  instance_destroy();
    with (obj_Fireportal) instance_destroy();

    // Create platforms and track IDs
    var platform_list = ds_list_create();

    // 1) Spawn a guaranteed start platform at far left, vertically centered
    //    always maximum width
    var spawn_pw  = max_w;
    var spawn_py  = room_height * 0.5;
    var spawn     = instance_create_layer(0, spawn_py, "Instances", obj_Platform);
    spawn.image_xscale = spawn_pw / sprite_get_width(spawn.sprite_index);
    ds_list_add(platform_list, spawn.id);

    // 2) Generate additional platforms
    var x_cursor = spawn_pw + irandom_range(min_gap, max_gap);
    while (x_cursor < portal_x) {
        var pw = irandom_range(min_w, max_w);
        var py = irandom_range(room_height * 0.25, room_height * 0.75);
        var p  = instance_create_layer(x_cursor, py, "Instances", obj_Platform);
        p.image_xscale = pw / sprite_get_width(p.sprite_index);
        ds_list_add(platform_list, p.id);
        x_cursor += pw + irandom_range(min_gap, max_gap);
    }

    // 3) Filter platforms for coin placement (exclude spawn and portal-adjacent)
    var coin_list = ds_list_create();
    for (var i = 0; i < ds_list_size(platform_list); i++) {
        var pid = ds_list_find_value(platform_list, i);
        if (!instance_exists(pid) || pid == spawn.id) continue; // skip spawn platform
        with (pid) {
            var left_edge  = x;
            var right_edge = x + sprite_get_width(sprite_index) * image_xscale;
            if (right_edge < portal_x - exclude_buffer || left_edge > portal_x + exclude_buffer) {
                ds_list_add(coin_list, pid);
            }
        }
    }
    // Fallback: if too few safe platforms, use all except spawn
    if (ds_list_size(coin_list) < max_coins) {
        ds_list_destroy(coin_list);
        coin_list = ds_list_create();
        for (var j = 0; j < ds_list_size(platform_list); j++) {
            var pid2 = ds_list_find_value(platform_list, j);
            if (pid2 != spawn.id) ds_list_add(coin_list, pid2);
        }
    }
    ds_list_shuffle(coin_list);

    // 4) Place exactly two coins: first above, second below selected platforms
    for (var c = 0; c < max_coins && c < ds_list_size(coin_list); c++) {
        var plat_id = ds_list_find_value(coin_list, c);
        if (!instance_exists(plat_id)) continue;
        with (plat_id) {
            var cx = x + (image_xscale * sprite_get_width(sprite_index)) * 0.5;
            var cy;
            if (c == 0) {
                // top coin
                cy = y - sprite_get_height(spr_coin) * 0.5 - 8;
            } else {
                // bottom coin
                cy = y + sprite_get_height(spr_coin) * 0.5 + 8;
                cy = clamp(cy, 64, room_height - 64);
            }
            instance_create_layer(cx, cy, "Instances", obj_Coin);
        }
    }
    ds_list_destroy(coin_list);
    ds_list_destroy(platform_list);

    // 5) Compute last platform Y for portal placement
    var last_idx = instance_number(obj_Platform) - 1;
    var last_py  = (last_idx >= 0)
                 ? instance_find(obj_Platform, last_idx).y
                 : room_height * 0.5;
    var py_end   = clamp(last_py - 64, 64, room_height - 64);

    // 6) Determine base Y for fire (above) & ice (below)
    var pad         = 32;
    var fire_base_y = clamp(py_end - pad, 64, room_height - 64);
    var ice_base_y  = clamp(py_end + pad, 64, room_height - 64);

    // 7) Adjust fire portal Y to avoid platforms
    var fire_y = fire_base_y;
    for (var off = 0; off <= room_height; off++) {
        if (fire_base_y - off >= 64
         && !place_meeting(portal_x, fire_base_y - off, obj_Platform)) {
            fire_y = fire_base_y - off;
            break;
        }
        if (fire_base_y + off <= room_height - 64
         && !place_meeting(portal_x, fire_base_y + off, obj_Platform)) {
            fire_y = fire_base_y + off;
            break;
        }
    }

    // 8) Adjust ice portal Y to avoid platforms
    var ice_y = ice_base_y;
    for (var off = 0; off <= room_height; off++) {
        if (ice_base_y + off <= room_height - 64
         && !place_meeting(portal_x, ice_base_y + off, obj_Platform)) {
            ice_y = ice_base_y + off;
            break;
        }
        if (ice_base_y - off >= 64
         && !place_meeting(portal_x, ice_base_y - off, obj_Platform)) {
            ice_y = ice_base_y - off;
            break;
        }
    }

    // 9) Spawn portals
    instance_create_layer(portal_x, fire_y, "Instances", obj_Fireportal);
    instance_create_layer(portal_x, ice_y,  "Instances", obj_Iceportal);
}
