/// @function scr_handle_input(inst)
/// @param inst  The player instance (obj_Blaze or obj_Glacia)
/// @description
///   Reads input for two characters: Blaze (A/D for left/right)
///   Uses W (Blaze) or ↓ (Glacia) for a normal jump (1× power), and S (Blaze) or ↑ (Glacia) to charge-up a more powerful jump, released to jump.
function scr_handle_input(inst) {
    // 1) Reset on R key
    if (keyboard_check_pressed(ord("R"))) {
        inst.x            = inst.start_x;
        inst.y            = inst.start_y;
        inst.hsp          = 0;
        inst.vsp          = 0;
        inst.can_jump     = false;
        // reset any jump charge
        if (variable_instance_exists(inst, "jump_charge")) inst.jump_charge = inst.min_jump_charge;
        return;
    }

    // 2) Determine key mappings per character
    var left_key, right_key;
    var normal_key, charge_key;
    if (inst.object_index == obj_Blaze) {
        left_key    = ord("A");
        right_key   = ord("D");
        normal_key  = ord("W");     // normal jump
        charge_key  = ord("S");     // charge jump
    } else if (inst.object_index == obj_Glacia) {
        left_key    = vk_left;
        right_key   = vk_right;
        normal_key  = vk_down;        // normal jump
        charge_key  = vk_up;          // charge jump
    } else {
        // fallback to Blaze mapping
        left_key    = ord("A");
        right_key   = ord("D");
        normal_key  = ord("W");
        charge_key  = ord("S");
    }

    // 3) Horizontal movement
    var dir = keyboard_check(right_key) - keyboard_check(left_key);
    inst.hsp = dir * inst.move_speed;

    // 4) Ground check for jumping
    inst.can_jump = place_meeting(
        inst.x,
        inst.y + sign(inst.gravity_direction),
        obj_Platform
    );

    // 5) Normal jump on key press
    if (keyboard_check_pressed(normal_key) && inst.can_jump) {
        inst.vsp = -inst.gravity_direction * inst.jump_strength;
        // clear any leftover charge
        inst.jump_charge = inst.min_jump_charge;
        inst.can_jump    = false;
    }

    // 6) Charging: hold charge_key to build up power
    if (keyboard_check(charge_key) && inst.can_jump) {
        // initialize charge if needed
        if (!variable_instance_exists(inst, "jump_charge")) inst.jump_charge = inst.min_jump_charge;
        var dt = delta_time / 1_000_000;
        inst.jump_charge = clamp(
            inst.jump_charge + inst.charge_rate * dt,
            inst.min_jump_charge,
            inst.max_jump_charge
        );
    }

    // 7) Release charge_key to perform a charged jump
    if (keyboard_check_released(charge_key) && inst.can_jump) {
        // ensure charge variable exists
        if (!variable_instance_exists(inst, "jump_charge")) inst.jump_charge = inst.min_jump_charge;
        inst.vsp = -inst.gravity_direction * inst.jump_strength * inst.jump_charge;
        // reset charge for next time
        inst.jump_charge = inst.min_jump_charge;
        inst.can_jump    = false;
    }
}