var _guiw = display_get_gui_width()
var _guih = display_get_gui_height()

var _middle_x = _guiw / 2

draw_set_halign(fa_center)

// Draw title
draw_set_font(fnt_rubik_lobby)
draw_text_color(_middle_x, _guih * .02, "Settings", c_aqua, c_white, c_aqua, c_white, 1)

// Draw options
var _y_start_op = _guih * .3
var _increment = _guih * .1

draw_set_valign(fa_middle)
draw_set_font(fnt_rubik_options)

for (var i = 0; i < settings; i++) {

	var _c = c_white
	
	if i = selected _c = c_aqua
	
	var _y = _y_start_op + (_increment * i)
	var _string = string(setting[i]) + ": " + option[i][variable_instance_get(id, "selected" + string(i))]
	draw_text_color(_middle_x, _y, _string, _c, _c, _c, _c, 1)
}

draw_set_valign(fa_top)
draw_set_halign(fa_left)