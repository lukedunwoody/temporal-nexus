var _guiw = display_get_gui_width()
var _guih = display_get_gui_height()

var _xpat = _guih * .02

// Draw title
draw_set_font(fnt_rubik_lobby)
draw_text_color(_xpat, _guih*.015, "Temporal", c_aqua, c_white, c_aqua, c_white, 1)
draw_text_color(_xpat, _guih*.125, "Nexus", c_white, c_aqua, c_white, c_aqua, 1)

// Draw options
var _y_start_op = _guih * .58
var _y_length_op = _guih*1.035 - _y_start_op
var _increment = _y_length_op / op_amnt

draw_set_valign(fa_middle)
for (var i = 0; i < op_amnt; i++) {

	var _c = c_white
	
	if i = selected _c = c_aqua
	
	if i = 0 draw_set_font(fnt_rubik_lobby) else draw_set_font(fnt_rubik_options)
	var _y = _y_start_op + (_increment * i)
	draw_text_color(_xpat, _y, option[i], _c, c_white, _c, c_white, 1)
}
draw_set_valign(fa_top)