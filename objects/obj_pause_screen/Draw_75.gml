var _guiw = display_get_gui_width()
var _guih = display_get_gui_height()

var _xpat = _guih * .02
var _ypat = _guih * .05
var _increment = _ypat

draw_set_alpha(alpha * alpha_max)
draw_rectangle_color(0, 0, _guiw, _guih, c_black, c_black, c_black, c_black, false)

draw_set_font(fnt_rubik_gameover)
draw_set_valign(fa_middle)

for (var i = op_amnt - 1; i >= 0; i--) {
	
	var _c = c_white
	if (i == selected) _c = c_aqua

	var _y = _guih - _ypat - _increment * (op_amnt - 1 - i)
	draw_text_color(_xpat, _y, option[i], _c, c_white, _c, c_white, 1)
}

draw_set_valign(fa_top)