

if (keyboard_check_pressed(vk_tab)) {
    // find our two players (first instance of each)
    var b = instance_find(obj_Blaze, 0);
    var g = instance_find(obj_Glacia, 0);
    if (b != noone && g != noone) {
        // if Blaze is active, deactivate him and activate Glacia
        if (b.active) {
            instance_deactivate_object(b);
            instance_activate_object(g);
        }
        // otherwise do the reverse
        else {
            instance_deactivate_object(g);
            instance_activate_object(b);
        }
    }
}
