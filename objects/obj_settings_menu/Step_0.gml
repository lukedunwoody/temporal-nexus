// Inputs
var _up_key = global.up_key_pressed
var _down_key = global.down_key_pressed
var _back_key = global.pause_key
var _select_key = global.select_key

if _back_key room_goto(rm_prev)

// Move through menu
selected += _down_key - _up_key
selected = ((selected % settings) + settings) % settings

// Use the options
if _select_key {
	switch(selected) {

		case 0: // Music Enabled
	
		selected0 = (selected0 + 1) % options0
		global.music_enabled = selected0
		audio_stop_all()
	
		break
	
		case 1: // Sound Effects Enabled
	
		selected1 = (selected1 + 1) % options1
		global.sfx_enabled = selected1
		audio_stop_all()
	
		break
	
		case 2: // Input Device Type
		
		selected2 = (selected2 + 1) % options2
		global.controller_enabled = selected2
	
		break
	
		case 3: // Window Mode
	
		selected3 = (selected3 + 1) % options3
		
		if selected3 == 0 {
		
			window_set_fullscreen(true)
		} else {
		
			window_set_fullscreen(false)
		}
		
		if selected3 == 1 {
		
			window_enable_borderless_fullscreen(true)
		} else {
		
			window_enable_borderless_fullscreen(false)
		}
		
		if selected3 == 2 {
		
			window_set_fullscreen(false)
			window_enable_borderless_fullscreen(false)
		}
	
		break
		
		case 4:
		
		selected4 = (selected4 + 1) % options4
		
		window_set_size(window_sizes[selected4][0], window_sizes[selected4][1])
		display_set_gui_size(window_sizes[selected4][0], window_sizes[selected4][1])
		
		break
	}
}