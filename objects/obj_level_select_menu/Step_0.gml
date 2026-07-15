// Inputs
var _left_key = global.left_key_pressed
var _right_key = global.right_key_pressed
var _up_key = global.up_key_pressed
var _down_key = global.down_key_pressed
var _select_key = global.select_key
var _back_key = global.pause_key

// Move through menu
selected += _right_key - _left_key
selected += (_down_key - _up_key) * 3
selected = ((selected % level_amnt) + level_amnt) % level_amnt

// Go back to menu
if _back_key {

	global.lobby_previous_room = "level_select"
	room_goto(rm_lobby)
}

// Use the options
if _select_key {
	
	for (var i = 0; i < level_amnt; i++) {
	
		if i == selected {
	
			global.play_dialog_boxes = true
			room_goto(asset_get_index("rm_level" + string(i + 1)))
		}
	}
}