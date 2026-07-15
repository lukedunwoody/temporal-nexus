// Inputs
var _up_key = global.up_key_pressed
var _down_key = global.down_key_pressed
var _select_key = global.select_key

// Move through menu
selected += _down_key - _up_key
selected = ((selected % op_amnt) + op_amnt) % op_amnt

// Use the options
if _select_key {
	switch(selected) {

		case 0: // Start game
		global.play_dialog_boxes = true
		room_goto(global.current_level)
	
		break
	
		case 1: // Level select
	
		room_goto(rm_level_select)
	
		break
	
		case 2: // Settings
		
		global.settings_previous_room = room
		room_goto(rm_settings)
	
		break
	
		case 3: // Quit
	
		game_end()
	
		break
	}
}