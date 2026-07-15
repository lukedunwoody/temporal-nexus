#region Inputs

if global.controller_enabled == 0 {

	global.left_key = keyboard_check(vk_left) or keyboard_check(ord("A"))
	global.right_key = keyboard_check(vk_right) or keyboard_check(ord("D"))
	global.up_key = keyboard_check(vk_up) or keyboard_check(ord("W"))
	global.down_key = keyboard_check(vk_down) or keyboard_check(ord("S"))
	
	global.left_key_pressed = keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"))
	global.right_key_pressed = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"))
	global.up_key_pressed = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"))
	global.down_key_pressed = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"))

	global.xaxis_left = global.right_key - global.left_key
	global.yaxis_left = global.down_key - global.up_key
	
	global.shoot_key = mouse_check_button_pressed(mb_left)
	global.throw_key = mouse_check_button_pressed(mb_right)
	global.melee_key = keyboard_check_pressed(ord("E"))
	
	global.pause_key = keyboard_check_pressed(vk_escape)
	global.select_key = keyboard_check_pressed(vk_enter)
}

if global.controller_enabled == 1 {
	var _gamepad = 0
	if gamepad_is_connected(_gamepad) {

		gamepad_set_axis_deadzone(_gamepad, .2)

		global.right_key = gamepad_button_check(_gamepad, gp_padr)
		global.left_key = gamepad_button_check(_gamepad, gp_padl)
		global.up_key = gamepad_button_check(_gamepad, gp_padu)
		global.down_key = gamepad_button_check(_gamepad, gp_padd)
		
		global.right_key_pressed = gamepad_button_check_pressed(_gamepad, gp_padr)
		global.left_key_pressed = gamepad_button_check_pressed(_gamepad, gp_padl)
		global.up_key_pressed = gamepad_button_check_pressed(_gamepad, gp_padu)
		global.down_key_pressed = gamepad_button_check_pressed(_gamepad, gp_padd)

		global.xaxis_left = gamepad_axis_value(_gamepad, gp_axislh)
		global.yaxis_left = gamepad_axis_value(_gamepad, gp_axislv)
		global.xaxis_right = gamepad_axis_value(_gamepad, gp_axisrh)
		global.yaxis_right = gamepad_axis_value(_gamepad, gp_axisrv)
		
		global.shoot_key = gamepad_button_check_pressed(_gamepad, gp_shoulderr)
		global.throw_key = gamepad_button_check_pressed(_gamepad, gp_shoulderl)
		global.melee_key = gamepad_button_check_pressed(_gamepad, gp_face2)
		
		global.pause_key = gamepad_button_check_pressed(_gamepad, gp_start)
		global.select_key = gamepad_button_check_pressed(_gamepad, gp_face1)
	}
}
	
#endregion

#region Pause Game

if global.pause_key {

    if !instance_exists(obj_pause_screen) {
        if instance_exists(obj_player) {
            instance_create_depth(0, 0, 0, obj_pause_screen);
        }
    } else {
        // Get the actual obj_pause_screen instance (not its children)
        for (var i = 0; i < instance_number(obj_pause_screen); i++) {
            var _inst = instance_find(obj_pause_screen, i);
            
            if (_inst.object_index == obj_pause_screen && _inst.alpha == 1) {
                with (_inst) {
                    instance_destroy();
                }
            }
        }
    }
}

#endregion