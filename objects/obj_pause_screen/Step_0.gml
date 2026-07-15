// fade in
alpha += alpha_spd
alpha = clamp(alpha, 0, 1)

// Inputs
var _up_key = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"))
var _down_key = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"))
var _select_key = keyboard_check(vk_enter)

// Move through menu
selected += _down_key - _up_key
selected = ((selected % op_amnt) + op_amnt) % op_amnt

// Use the options
if _select_key {
	switch(selected) {

		case 0: // Resume
	
		instance_destroy()
	
		break
	
		case 1: // Settings
	
		global.settings_previous_room = room
		room_goto(rm_settings)
	
		break
	
		case 2: // Lobby
	
		room_goto(rm_lobby)
	
		break
	}
}