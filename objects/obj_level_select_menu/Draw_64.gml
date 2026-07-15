var _guiw = display_get_gui_width()
var _guih = display_get_gui_height()

var _x_center = _guiw / 2

var _xscale = _guiw / room_width
var _yscale = _guih / room_height

// Draw levels
draw_set_font(fnt_rubik_options)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)

for (var i = 0; i < level_amnt; i++) {

	var _c = c_white
	if i == selected _c = c_aqua

	var _row = i / columns
	var _column = i % columns

	draw_text_color(column[_column] * _xscale, row[_row] * _yscale, string(i + 1), _c, _c, _c, _c, 1)
}

for (var i = 0; i < array_length(header_rows); i++) {

	var _c = header_color[i]

	draw_text_color(_x_center, (header_rows[i] + 4) * _yscale, header_content[i], _c, _c, _c, _c, 1)
}

draw_set_halign(fa_left)
draw_set_valign(fa_top)