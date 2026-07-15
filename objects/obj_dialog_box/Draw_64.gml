var _guiw = display_get_gui_width()
var _guih = display_get_gui_height()

var _x1 = _guiw * 0.1
var _x2 = _guiw * 0.9
var _y1 = _guih * 0.05
var _y2 = _guih * 0.2

draw_rectangle_color(_x1, _y1, _x2, _y2, c_black, c_black, c_black, c_black, 0)
draw_rectangle_color(_x1, _y1, _x2, _y2, c_white, c_white, c_white, c_white, 1)

draw_set_font(fnt_rubik)
// Use same ratio as before, but relative to rectangle width/height
var _rect_width  = _x2 - _x1;
var _rect_height = _y2 - _y1;

var _x = _x1 + (_rect_width  * 0.0125); // equivalent to _guiw * 0.1625 - _guiw * 0.15
var _y = _y1 + (_rect_height * 0.1);    // equivalent to _guiw * 0.0275 - _guih * 0.025

draw_set_color(c_white)
draw_text(_x, _y, text)

draw_set_valign(fa_bottom)
// Draw hint near bottom of rectangle
var _hint_y = _y2 - (_rect_height * 0.1);
draw_text(_x, _hint_y, "Press Shoot to continue");
draw_set_valign(fa_top)