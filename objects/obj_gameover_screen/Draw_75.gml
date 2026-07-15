var _guiw = display_get_gui_width()
var _guih = display_get_gui_height()

draw_set_alpha(alpha * alpha_max)
draw_rectangle_color(0, 0, _guiw, _guih, c_black, c_black, c_black, c_black, false)

draw_set_font(fnt_rubik_gameover)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_text_color(_guiw / 2, (_guih / 5) * 4, "- Press Shoot to Restart -", c_white, c_white, c_white, c_white, alpha)

draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_alpha(1)