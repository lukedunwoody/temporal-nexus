if global.replay_playing {

	var _guiw = display_get_gui_width()
	var _guih = display_get_gui_height()

	draw_set_font(fnt_rubik_gameover)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text_color(_guiw/2,(_guih/7) * 6, "Press Shoot to Continue", c_white, c_white, c_white, c_white, 1)

	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	draw_set_alpha(1)
}